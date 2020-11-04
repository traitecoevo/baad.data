##' Load data from the Biomass and Allometry Database.
##'
##' The first time this is run for a given version, this function will
##' download the Biomass and Allometry Database (BAAD) from github, using numbered versions),
##' unpack the resulting zip file and load the csv files.  This might
##' take a few seconds to a minute.  Subsequent calls will be
##' considerably quicker because we cache both the downloaded data and
##' the result of reading the csv.  Subsequent calls after \emph{that}
##' will be essentially instantaneous.
##'
##' The function \code{baad_delete} deletes all traces of downloaded
##' BAAD data if a version is not given, or a specific version if that
##' is listed.
##' @title Load the BAAD database
##' @param version Version to load.  Verion "1.0.0" corresponds to the
##'   version published in Ecology in 2015.  Other valid versions are
##'   "0.1.0", "0.2.0" and "0.9.0" which are stored on github but are
##'   of historical interest only.
##' @param path Optional path in which to store the data.  If omitted
##'   we use \code{rappdirs} to generate a reasonable path.
##' @export
##' @examples
##' \dontrun{
##' baad <- baad_data()
##' head(baad$data)
##' }
baad_data <- function(version=NULL, path=NULL) {
  datastorr::github_release_get(baad_data_info(path), version)
}

##' Information to describe how to process github releases
##'
##' @title Github release information
##'
##' @param path Optional path in which to store the data.  If omitted
##'   we use \code{rappdirs} to generate a reasonable path.
baad_data_info <- function(path=NULL) {
  datastorr::github_release_info(repo="dfalster/baad",
                                 filename="baad_data.zip",
                                 read=baad_unpack,
                                 path=path)
}

##' Get release versions
##' @title Get release versions
##' @param local Should we return local (TRUE) or github (FALSE)
##'   version numbers?  Github version numbers are pulled once per
##'   session only.  The exception is for
##'   \code{github_release_version_current} which when given
##'   \code{local=TRUE} will fall back on trying github if there are
##'   no local versions.
##' @param path Optional path in which to store the data.  If omitted
##'   we use \code{rappdirs} to generate a reasonable path.##'
##' @export
baad_data_versions <- function(local=TRUE, path=NULL) {
  datastorr::github_release_versions(baad_data_info(path), local)
}

##' @export
##' @rdname baad_data_versions
baad_data_version_current <- function(local=TRUE, path=NULL) {
  datastorr::github_release_version_current(baad_data_info(path), local)
}

##' @export
##' @rdname baad_data
baad_data_del <- function(version, path) {
  datastorr::github_release_del(baad_data_info(path), version)
}

baad_data_release <- function(description) {
  datastorr::github_release_create(baad_data_info(path),
                                   description=description, ...)
}

## Given a filename corresponding to a downloaded resource, convert it
## into an R object.
baad_unpack <- function(filename) {
  dest <- tempfile()
  files <- utils::unzip(filename, exdir=dest)

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
  baad <- lapply(csv_files, utils::read.csv, stringsAsFactors=FALSE)
  names(baad) <- sub("baad_", "",
                     tools::file_path_sans_ext(basename(csv_files)))

  bib_file <- dir(dest, pattern="\\.bib$", full.names=TRUE)[[1]]
  baad[["bib"]] <- bibtex::read.bib(bib_file)

  baad
}
