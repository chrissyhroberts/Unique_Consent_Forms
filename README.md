# Unique_Consent_Forms
Example form to create a uniquely barcoded consent form. 

This is a very basic example of how R markdown can be scripted to create a set of uniquely barcoded consent forms. 
By using the QRcode from the consent form to assign unique IDs to participants, the process of assignment and ascertainment is made more robust. There is no need to use stickers or complex systems to assign IDs. 

The code is an R script that acts as a controller and an RMD file which creates the final PDF/Word forms. 
The controller assigns IDs, generates QRCodes and sends these to the RMD file, which binds them with the information/consent sheet and creates either PDF or Word files that can be printed. 

The code in the R file includes a simple system for assigning non-overlapping unique ID (UID) codes. 

The UIDs including ISO3166-1 alpha-2 country codes at the beginning. Numerical series between countries do not overlap and numerical series map to country codes in alphabetical order so numerical series can be used to identify specimens, i.e. LA (1xxxx) MM (2xxxx) MW (3xxxx) MZ (4xxxx) and ZW (5xxxx)

LA<-paste("LA","-",10000:19999,sep="")
MM<-paste("MM","-",20001:29999,sep="")
MW<-paste("MW","-",30000:39999,sep="")
MZ<-paste("MZ","-",40000:49999,sep="")
ZW<-paste("ZW","-",50000:59999,sep="")
