#' Text/Expression labels vor BAAD variables
#'
#' @param dictionary data frame, from \code{\link{baad_data}()$dictionary}
#' @param variable character, variable described in data dictionary
#' @param as_expression logical, should label be returned as character string or expression?
#'
#' @return Character string or expression. For expressions, units are returned with numeric superscripts
#' @export
#'
#' @rdname baad_labeller
#' @examples
#' \dontrun{
#' dictionary <- baad.data::baad_data()$dictionary
#'
#' baad_labeller(dictionary = dictionary,
#'               variable = "r.st",
#'               as_expression = TRUE)
#'
#' }
#'
baad_labeller <- function(dictionary, variable, as_expression = FALSE){


    if(!base::inherits(x = dictionary,
                       what = "data.frame")){
        stop("Provide a baad dictionary data frame.")
    }


    if(sum(colnames(dictionary) %in% c("variable", "units", "label"))!= 3){
        stop(
            "Provide a valid baad dictionary data frame with at least columns 'variable', 'label' and 'unit'.")
    }


    label_string <- tools::toTitleCase(dictionary$label[dictionary$variable == variable])
    if(nchar(label_string) == 0 ){
        stop("Supplied variable not found in dictionary.")
    }
    if(is.na(label_string)){
        label_string <- "Unspecified"
        warning("Label in dictionary is missing. Setting to 'unspecified'.")
    }

    unit_string <- dictionary$units[dictionary$variable == variable]
    if(is.na(unit_string)){
        unit_string <- "-"
        warning("Unit in dictionary is missing (NA). Setting to '-'.")
    }

    if(!as_expression){

        print_label <- base::paste0(label_string,
                                    " (",
                                    unit_string,
                                    ")")
    } else {

        label_string <- gsub(pattern = "[ ]",
                             replacement = "~",
                             x = label_string)

        unit_string <- base::gsub(pattern = "([0-9]+)",
                                  replacement = "\\*\\*\\1",
                                  x = unit_string,
                                  perl = TRUE)


        # print_label <- base::bquote(.(label)~ .(unit)))
        print_label <- base::parse(text = paste0(label_string,
                                                 "~(",
                                                 unit_string,
                                                 ")"))
    }
    return(print_label)

}
