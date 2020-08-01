#' Construct a client to talk to the CMDC api
#'
#' @param apikey A string containing the APIKEY.
#' @return An S3 object with class ccdClient that implements routines for accessing CMDC API endpoints
#'
#' @export
#'
#' @exportPattern ^[^\.]
#' @importFrom magrittr "%>%"
#' @export %>%
client <- function(apikey = NULL) {
  pyClient = ccdPY$Client(apikey)
  fields <- list(pyClient = pyClient)
  structure(fields, class = c("ccdClient"))
}


#' Print information about the client and current request
#'
#' @export
print.ccdClient <- function (x)
  print(x$pyClient)


#' List all datasets accessible by the client
#'
#' @export
datasets.ccdClient <-
  function (x)
    reticulate::py_list_attributes(x$pyClient)

#' Fetch the currently constructed dataset
#'
#' @return A data.frame (tibble) containing requested data
#'
#' @export
fetch.ccdClient <- function (x) {
  tibble::as_tibble(x$pyClient$fetch())
}


#' Fetch the currently constructed dataset
#'
#' @return A string containing the API Key
#'
#' @export
register.ccdClient <- function (x, ...) {
  x$pyClient$register(...)
}


#' Reset the current request on this client
#'
#' @return The client
#'
#' @export
reset.ccdClient <- function (x) {
  x$pyClient$reset()
  x
}


#' Get information about the API as a whole (`info(client)`) or a specific
#' endpoint (`info(client, endpoint)`, for example `info(client, "demographics")`)
#'
#' @export
info.ccdClient <- function(cl, x = NULL) {
  print_datasets <- function() {
    print("Datasets are:")
    cat(c("", datasets(cl)), sep = "\n- ")
  }
  if (is.null(x)) {
    print(cl)
    print_datasets()
    return(cl)
  }
  if (reticulate::py_has_attr(cl$pyClient, x)) {
    print(cl$pyClient[[x]])
  } else {
    cat("Unknown dataset", x , "requested. Datasets are:")
    print_datasets()
  }
  return(cl)
}
