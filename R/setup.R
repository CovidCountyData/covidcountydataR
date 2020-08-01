#' @export
datasets <- function(x)
  UseMethod("datasets")

#' @export
fetch <- function(x)
  UseMethod("fetch")

#' @export
reset <- function(x)
  UseMethod("reset")

#' @export
register <- function(x, ...)
  UseMethod("register")

#' @export
info <- function(client, dataset)
  UseMethod("info")

ccdPY <- NULL

.onLoad <- function (libname, pkgname) {
  ccdPY <<- reticulate::import("covidcountydata", delay_load = TRUE)

  # get swagger file
  res <-
    httr::RETRY("GET", "https://api.covid.valorum.ai/swagger.json", times =
                  5)

  # TODO: error handling...

  # extract list of endpoints
  nms <- names(httr::content(res)$paths)
  endpoints <-
    simplify2array(lapply(nms, function(x)
      gsub('/', '', x)))

  # get this environment, into which we'll evaluate the generic functions
  env <- parent.env(environment())

  # for each endpoint...
  for (endpoint in endpoints) {
    if (endpoint == "swagger.json") {
      next
    cm}

    # create a generic function `endpoint <- function(arg, ...) UseMethod("endpoint")`
    epSym <- rlang::sym(endpoint)
    genCode <-
      rlang::expr(!!epSym <- function(arg, ...)
        UseMethod(!!endpoint))
    eval(genCode, envir = env)

    # add the endpoint generics to the namespace
    assignInMyNamespace(endpoint, env[[endpoint]])

    # create a method of the generic function for the ccdClient class
    methodStr <- paste0(endpoint, ".ccdClient")
    methodSym <- rlang::sym(methodStr)
    methodBody <- rlang::expr(function(obj, ...) {
      obj$pyClient[[!!endpoint]](...)
      obj
    })
    methodCode <- rlang::expr(!!methodSym <- !!methodBody)
    eval(methodCode, envir = env)

    method <- env[[methodStr]]
    registerS3method(endpoint, "ccdClient", method, envir = env)
  }
}

#' @export
install_ccdPY <- function() {
  reticulate::py_install("covidcountydata", pip = TRUE)
}
