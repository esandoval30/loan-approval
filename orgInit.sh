#Create Loan object metadata in local
#sfdx shane:object:create --label="Loan" --plural="Loans" --api=Loan__c --type=custom --nametype=AutoNumber - --autonumberformat="Loan-{0000000000}"
#Add fields
#sfdx shane:object:field -o  Loan__c -a Amount__c -n "Loan Amount" -t Number  --precision=15 --scale=2
#sfdx shane:object:field -o  Loan__c -a Broker_Status__c -n "Broker Status" -t Picklist  --picklistvalues="Approved,Deactivated,Watch List" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Broker_Tier__c -n "Broker Tier" -t Picklist  --picklistvalues="Key Account,Non Key Account" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Client_Risk_Rating__c -n "Client Risk Rating" -t Number  --precision=15 --scale=0
#sfdx shane:object:field -o  Loan__c -a Credit_Score__c -n "Credit Score" -t Number  --precision=15 --scale=0
#sfdx shane:object:field -o  Loan__c -a Credit_Score_Borrower_2__c -n "Credit Score Borrower 2" -t Number  --precision=15 --scale=0
#sfdx shane:object:field -o  Loan__c -a Current_Term_In_Months__c -n "Current Term (in Months)" -t Number  --precision=15 --scale=0
#sfdx shane:object:field -o  Loan__c -a Employment_Status_Borrower_2__c -n "Employment Status Borrower 2" -t Picklist  --picklistvalues="Commissions,Contract,Hourly,Other,Pension,Salary,Self-employed" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Employment_Status__c -n "Employment Status" -t Picklist  --picklistvalues="Commissions,Contract,Hourly,Other,Pension,Salary,Self-employed" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Global_Debt_Servicing_Ratio__c -n "Global Debt/Servicing ratio" -t Number  --precision=15 --scale=2
#sfdx shane:object:field -o  Loan__c -a Loan_Id__c -n "Loan Id" -t Text -l 40 -r --unique --externalid
#sfdx shane:object:field -o  Loan__c -a Interest_Rate__c -n "Interest Rate" -t Number  --precision=15 --scale=2
#sfdx shane:object:field -o  Loan__c -a Loan_To_Value__c -n "Loan to Value" -t Number  --precision=15 --scale=0
#sfdx shane:object:field -o  Loan__c -a Mortgage_Position__c -n "Mortgage Position" -t Picklist  --picklistvalues="1,2,3" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Mortgage_Purpose__c -n "Mortgage Purpose" -t Picklist  --picklistvalues="Equity Takeout,Purchase,Purchase Rent to Own,Refinance,Refinance for Debt Consolidation" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Occupancy_Type__c -n "Occupancy Type" -t Picklist  --picklistvalues="Owner,Rent To Own,Rental" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Property_Type__c -n "Property Type" -t Picklist  --picklistvalues="Apartment High Rise,Apartment Low Rise,Row,Semi-detached,Single" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Self_Employed__c -n "Self-Employed?" -t Checkbox  --default=false
#sfdx shane:object:field -o  Loan__c -a Stage__c -n "Stage" -t Picklist  --picklistvalues="Declined,Approved,Application,Commit" --picklistdefaultfirst
#sfdx shane:object:field -o  Loan__c -a Total_Debt_Servicing_Ratio__c -n "Total Debt/Servicing ratio" -t Number  --precision=15 --scale=2


#Add Tab
#sfdx shane:object:tab -o Loan__c -i 17
#Add PermissionSet
#sfdx shane:permset:create -n LoanAdmin -o Loan__c -t
#Ok, we're ready to deploy all of this stuff
sfdx force:org:create -f config/project-scratch-def.json -d 1 -s -w 3
#push source code into scratch org
sfdx force:source:push
#create user
sfdx force:user:password:generate
#assign permset to user
sfdx force:user:permset:assign --permsetname LoanAdmin
#Bulk Load data
sfdx force:data:bulk:upsert -s Loan__c -f data/loans.csv -i Loan_Id__c
#Install EPB Model Accuracy Package
#sfdx force:package:install -p 04t4J000002ASSJ
#Open org
sfdx force:org:open -p /lightning/setup/SetupOneHome/home