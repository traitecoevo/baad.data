##' Load the baad database.
##'
##' The first time this is run for a given version, this function will
##' download the baad database, either from the Ecology website (with
##' version "ecology" or from github (numbered versions), unpack the
##' resulting zip file and load the csv files.  This might take a few
##' seconds to a minute.  Subsequent calls will be considerably
##' quicker because we cache both the downloaded data and the result
##' of reading the csv.  Subsequent calls after \emph{that} will be
##' essentially instantaneous.
##'
##' The function \code{baad_delete} deletes all traces of downloaded
##' baad data if a version is not given, or a specific version if that
##' is listed.
##' @title Load the baad database
##' @param version Version to load.  "ecology" the published verison.
##' Other valid versions are "0.2.0", "0.9.0" and "1.0.0" which are
##' stored on github.  The "1.0.0" release corresponds to the
##' "ecology" release.
##' @export
##' @examples
##' baad <- baad_data()
##' head(baad$data)
baad_data <- function(version="ecology") {
  baad_storr()$get(version)
}

##' @export
##' @rdname baad_data
baad_delete <- function(version=NULL) {
  if (is.null(version)) {
    unlink(baad_path(), recursive=TRUE)
  } else {
    baad_storr()$del(version)
  }
}

##' List known versions of the baad database.  The last version
##' returned is most recent.
##' @title BAAD version
##' @param type Where to look for versions: options are \code{global},
##' which checks github and includes the published \code{ecology}
##' version, \code{github} which is the github releases only and
##' \code{local} which is versions downloaded to this computer.
##' @export
baad_versions <- function(type) {
  v <- switch(
    type,
    global=c(baad_versions("github"), "ecology"),
    github=storr::github_release_versions("dfalster/baad"),
    local=baad_storr()$list(),
    stop("Unknown type ", type))
  baad_versions_sort(v)
}

## Sort the versions, but put "ecology" in approximately the right
## place.  We'll make the github release 1.0.1 I think so that this is
## sorts stably.
baad_versions_sort <- function(v) {
  vv <- v
  vv[v == "ecology"] <- "1.0.0"
  v[order(numeric_version(vv))]
}

##' @importFrom rappdirs user_data_dir
baad_path <- function() {
  rappdirs::user_data_dir("baad")
}

##' @importFrom storr storr
baad_env <- new.env(parent=emptyenv())
baad_storr <- function() {
  ## Probably this pattern should be done with a storr too?
  if (is.null(baad_env$baad)) {
    baad_hook <- storr::fetch_hook_download(baad_url, baad_unpack)
    dr <- storr::driver_external(storr::driver_rds(baad_path()), baad_hook)
    baad_env$baad <- storr::storr(dr)
  }
  baad_env$baad
}

## Given a version, return the url for that resource:
## (import httr here to force installation as it is only a Suggests of
## storr).
##' @importFrom httr GET
baad_url <- function(version, namespace) {
  if (version == "ecology") {
    "http://www.esapubs.org/archive/ecol/E096/128/baad_data.zip"
  } else {
    storr::github_release_file("dfalster/baad", "baad_data.zip")(version)
  }
}

## Given a filename corresponding to a downloaded resource, convert it
## into an R object.
##' @importFrom bibtex read.bib
baad_unpack <- function(filename) {
  dest <- tempfile()
  files <- unzip(filename, exdir=dest)

  ## Some versions have a leading baad_data, while others don't,
  ## others are badly packaged.  This is terrible, and might get
  ## updated later.
  for (tld in c("baad_data", "baad_csv", "baad")) {
    if (file.exists(file.path(dest, tld))) {
      dest <- file.path(dest, tld)
      break
    }
  }

  csv_files <- dir(dest, pattern="\\.csv$", full.names=TRUE)
  baad <- lapply(csv_files, read.csv, stringsAsFactors=FALSE)
  names(baad) <- sub("baad_", "",
                     tools::file_path_sans_ext(basename(csv_files)))

  bib_file <- dir(dest, pattern="\\.bib$", full.names=TRUE)[[1]]
  baad[["bib"]] <- bibtex::read.bib(bib_file)

  baad
}
