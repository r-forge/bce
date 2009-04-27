


filename <- "273439.xls"
filename <- "bla.XLS"




library(RODBC)
conn <- odbcConnectExcel(filename)
tablename <- sqlTables(conn)$TABLE_NAME[1]
data <- sqlFetch(conn,tablename,as.is=TRUE)
close(conn) 





library(RDCOMClient)
xls <- COMCreate("Excel.Application")
xls[["Workbooks"]]$Open(paste(getwd(),"/",filename,sep="")) 
sheet <- xls[["ActiveSheet"]]
mydata <- sheet[["UsedRange"]][["value"]] 
xls$Quit()
char <- unlist(mydata)

