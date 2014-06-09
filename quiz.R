# excel
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", dest="test.xlsx", method="curl")
dat <- read.xlsx("test.xlsx",sheetIndex=1)
head(dat) 
sum(dat$Zip*dat$Ext,na.rm=T)

#xml
library(XML)
url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url, dest="test.xml", method="curl")
doc <- xmlTreeParse("test.xml",useInternal=TRUE)
rootNode = xmlRoot(doc)
a=xpathSApply(rootNode, "//zipcode", xmlValue)
length(a[a==21231])

#csv
library(data.table)
url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, dest="test.csv", method="curl")
DT = fread("test.csv")
head(DT)

#sqldf
library(sqldf)
url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, dest="acs.csv", method="curl")
acs = fread("acs.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

#html
url="http://biostat.jhsph.edu/~jleek/contact.html"
con = url(url)
htmlCode = readLines(con)
close(con)
a = c(10,20,30,100)
for (i in 1:length(a)) {
  print(nchar(htmlCode[a[i]]))
}

#fix width
url="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, dest="test.for", method="curl")
a = read.fwf("test.for" , widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(a$V4)

#quiz3.1 use Rcurl to read https file directly
u=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
a = read.csv(text=u)
which(a$ACR==3 & a$AGS==6)

# quiz3.2 
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", dest="test.jpeg", method="curl")
a = readJPEG("test.jpeg", native=TRUE)
head(a)
quantile(a, probs=seq(0,1, by=.1))

#quiz3.3
library(RCurl)
library(data.table)
x=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
a=read.csv(text=x, skip=4)
y=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
b=read.csv(text=y)
#remove rows without gdp
a = a[grep("^[0-9]", a$X.1), ]
# change gdp into numeric values
a$X.1 = as.numeric(as.character(a$X.1))
c=merge(a,b, by.x="X", by.y="CountryCode")
head(c[sort(c$X.1, decreasing=T, index.return=T)$ix,], n=13)
# get mean of gdp by income.group in data.table
cdt = as.data.table(c)
colnames(cdt)[2]= "gdp"
cdt[,mean(gdp), by="Income.Group"]
#or
library(plyr)
colnames(c)[2]= "gdp"
ddply(c, .(Income.Group), summarise, mean(gdp))

#quiz3.4
gdpq= cut(c$gdp, breaks=quantile(c$gdp, probs=seq(0,1,by=.2)), include.lowest=T)
table(gdpq, c$Income.Group)

#quiz4.1
x=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
a =read.csv(text=x)
strsplit(colnames(a), "wgtp") 

#quiz4.2
x=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
a=read.csv(text=x, skip=4)
# replace comma and white spaces
head(a)
a$X.4=gsub("[,| ]", "", a$X.4)
mean(as.numeric(a$X.4[grep("^[0-9]", a$X.4)])[1:190])

#quiz4.4
x=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
a=read.csv(text=x, skip=4)
y=getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
b=read.csv(text=x)
a = a[grep("^[0-9]", a$X.1), ]
# change gdp into numeric values
a$X.1 = as.numeric(as.character(a$X.1))
c=merge(a,b, by.x="X", by.y="CountryCode")
dim(c[grep("Fiscal year end: June", c$Special.Notes),])

#quiz4.5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
head(amzn)
head(sampleTimes)
length(grep("2012", sampleTimes))
length(grep"2012-")