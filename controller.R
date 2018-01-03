#########################################################################################
# ODK Consent form generator
#########################################################################################
#
# Step one of this script is to generate QR codes
#
# Step two is to output individual records to a temp file, then bind their data with
# any images to make a pdf document.
#
# This work is licensed under Creative Commons Attribution-ShareAlike 3.0 Unported License
# http://creativecommons.org/licenses/by-sa/3.0/"
#########################################################################################
# Requirements
#
# QRENCODER
# devtools::install_github("hrbrmstr/qrencoder")
#
#needs latex and pandoc (external installations, use homebrew)
library(knitr)
library(readr)
library(dplyr)
library(anytime)
library(qrencoder)

#
#########################################################################################

#make full list of UIDs including ISO3166-1 alpha-2 country codes
# country codes in alphabetical order so numerical series can be used to identify specimens
# i.e. LA (1xxxx) MM (2xxxx) MW (3xxxx) MZ (4xxxx) and ZW (5xxxx)
LA<-paste("LA","-",10000:19999,sep="")
MM<-paste("MM","-",20001:29999,sep="")
MW<-paste("MW","-",30000:39999,sep="")
MZ<-paste("MZ","-",40000:49999,sep="")
ZW<-paste("ZW","-",50000:59999,sep="")

try(system(command = "mkdir Forms"),silent = T)


# enter loop for each row of the csv file


print_form<-function(id)
{
  # generate barcode
  png(filename = "barcode.png",width = 10,height = 8,units = "cm",res = 150)

  par(mfrow=c(1,2),mar=c(0.2,0.2,0.2,0.2))
  image(qrencode_raster(LA[10]),
        asp=1, col=c("white", "black"), axes=FALSE,
        xlab="", ylab="")
  text(x = 0.015,y=1.1,paste("ID : ",id),cex=1,pos=4)
  plot(0:1,0:1,axes=F,pch="",xlab="",ylab="")

  text(x = -0.05,y=0.8,"Name : ",cex=1,pos=4)
  text(x = 0.1,y=0.78,"____________________________",cex=1,pos=4)
  text(x = -0.05,y=0.65,"Date of Birth : ",cex=1,pos=4)
  text(x = 0.1,y=0.63,"____________________________",cex=1,pos=4)
  text(x = 0.35,y=0.65,"dd / mm / yyyy",cex=1,pos=4,col="light grey")
  polygon(x = c(0,1.04,1.04,0),y = c(0.175,0.175,0.6,0.6))
  text(x = 0.00,y=0.2,paste("Signature/Thumbprint"),cex=1.0,pos=4)
  dev.off()
  write.table("id.txt",x = id,quote = F,row.names = F,col.names = F)
  #run RMD script to create report in pdf, pulling in any jpgs
  rmarkdown::render(input = "QRENCODE.Rmd",
                    output_format = "pdf_document",
                    output_file = paste(id,".pdf", sep=''),
                    output_dir = "Forms")

}

for(i in LA[1]){print_form(i)}

## Background
#This work is licensed under Creative Commons Attribution-ShareAlike 3.0 Unported License
#http://creativecommons.org/licenses/by-sa/3.0/"

#Nuff respect to VP Nagraj [twitter @vpnagraj] from whose scripts I reused some of the control structure for calling RMD from another R script
#See http://nagraj.net/notes/multiple-rmarkdown-reports/



devtools::install_github("hrbrmstr/qrencoder")

