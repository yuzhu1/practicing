# This script converts a CSV file with headers to XML or JSON, depending on
# the command line argument supplied.
#
# This script will be executed by calling:
#
#    ```
#    Rscript src/lab1.R xml/json <filename>
#    ```
#
# Output of XML and JSON should be printed to stdout.
require(jsonlite)
require(XML)

setwd("/Users/nancyzhu/lab-json-xml-r-yuzhu1")

#Convert CSV to Dataframe
parse_csv <- function(filename) {
    # Parse a CSV file by separating it into headers and additional data.
    #
    # Args
    # filename: A path to a CSV file.
    #     
    # Returns
    # An R structure containing the headers from the csv file and the data.
    result <- read.csv(file=filename, header=T, stringsAsFactors=F)
    return(result)
}

#data1 <- parse_csv("sample.csv")
#data1

#XML
#https://stackoverflow.com/questions/35234863/how-convert-a-data-frame-into-a-xml-file-with-r
library(XML)

convertToXML <- function(df){
    xml <- xmlTree("record")
    for (i in 1:nrow(df)){
        xml$addTag("patient", close=FALSE)
        for (j in names(df)){
            xml$addTag(j, df[i,j])
        }
        xml$closeTag()
    }
    xml$closeTag()
    return(cat(saveXML(xml)))
}

#dftoxml <- convertToXML(data1)


#JSON
#https://rdrr.io/cran/jsonlite/man/fromJSON.html
library(jsonlite)

convertToJSON <- function(df){
    jsondata1 <- toJSON(df, pretty=TRUE)
    cat(jsondata1)
}

#dftojson <- convertToJSON(data1)


#Main Function
#https://swcarpentry.github.io/r-novice-inflammation/05-cmdline/
main <- function() {
    args <- commandArgs(trailingOnly = TRUE)
    action <- args[1]
    filenames <- args[-1]
    stopifnot(action %in% c("xml", "json"))
    
    for (f in filenames) {
        process(f, action)
    }
}

process <- function(filename, action) {
    dat <- parse_csv(filename)
    
    if (action == "xml") {
        values <- apply(dat, 1, convertToXML(dat))
    } else if (action == "json") {
        values <- apply(dat, 1, convertToJSON(dat))
    }
    return(values)
}

main()




