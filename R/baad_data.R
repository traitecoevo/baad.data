##' Load the baad database.
##'
##' The first time this is run for a given version, this function will
##' download the baad database from github, using numbered versions),
##' unpack the resulting zip file and load the csv files.  This might
##' take a few seconds to a minute.  Subsequent calls will be
##' considerably quicker because we cache both the downloaded data and
##' the result of reading the csv.  Subsequent calls after \emph{that}
##' will be essentially instantaneous.
##'
##' The function \code{baad_delete} deletes all traces of downloaded
##' baad data if a version is not given, or a specific version if that
##' is listed.
##' @title Load the baad database
##' @param version Version to load.  Verion "1.0.0" corresponds to the
##'   version published in Ecology in 2015.  Other valid versions are
##'   "0.1.0", "0.2.0" and "0.9.0" which are stored on github but are
##'   of historical interest only.
##' @export
##' @import storr
##' @examples
##' \dontrun{
##' baad <- baad_data()
##' head(baad$data)
##' }
baad_data <- function(version=NULL) {
  github_release_storr_get(baad_data_info(), version)
}

baad_data_info <- function() {
  github_release_storr_info("dfalster/baad",
                            "baad_data.zip",
                            baad_unpack)
}

## Below here are wrappers around the storr functions but with our
## information object.  We could actually save baad_data_info() as
## an *object* in the package, but I prefer this approach.

##' @export
##' @rdname baad_data
##' @param type Type of version to return: options are "local"
##'   (versions installed locally) or "github" (versions available on
##'   github).  With any luck, "github" is a superset of "local".  For
##'   \code{baad_data_version_current}, if "local" is given, but there
##'   are no local versions, then we do check for the most recent
##'   github version.
baad_data_versions <- function(type="local") {
  github_release_storr_versions(baad_data_info(), type)
}

##' @export
##' @rdname baad_data
baad_data_version_current <- function(type="local") {
  github_release_storr_version_current(baad_data_info(), type)
}

##' @export
##' @rdname baad_data
baad_data_del <- function(version) {
  github_release_storr_del(baad_data_info(), version)
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
