sfdx force:org:create -f config/project-scratch-def.json -d 1 -s -w 3
sfdx force:source:push
sfdx force:user:password:generate
#assign permset to user
sfdx force:user:permset:assign --permsetname LoanAdmin
#Load Opportunity and Recommendation data
sfdx force:data:bulk:upsert -s Loan__c -f data/loans.csv -i Loan_Id__c -w 3
sfdx force:apex:execute -f data/recommendations.cls
#Install EPB Model Accuracy Package
#sfdx force:package:install -p 04t4J000002ASSJ
#Open org
sfdx force:org:open -p /lightning/setup/SetupOneHome/home