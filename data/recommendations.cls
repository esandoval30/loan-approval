List<Recommendation> recs = new List<Recommendation>();
ContentAsset[] all_assets = [select id,masterlabel from ContentAsset];
Recommendation r;

for (ContentAsset a : all_assets) {
    if (a.masterlabel.equals('shutterstock_483396691_1')) {
        r = new Recommendation();
        r.name = 'Free Webinar';
        r.Description = 'How To Improve Your Credit Score';
        r.Category__c = ' Credit Score';
        r.Sub_Category__c = 'Improve Your Credit Score';
        r.AcceptanceLabel ='Sign up';
        r.RejectionLabel = 'No Thanks';
        r.imageId = a.id;
        r.actionreference = 'Simple_Message_Flow';
        recs.add(r);
    }
    if (a.masterlabel.equals('kitchen')) {
        r = new Recommendation();
        r.name = 'Home Improvement Loan';
        r.Description = 'Add Value To Your Home';
        r.Category__c = 'Products';
        r.Sub_Category__c = 'Low Interest Products';
        r.AcceptanceLabel ='Apply';
        r.RejectionLabel = 'Not Interested';
        r.imageId = a.id;
        r.actionreference = 'Simple_Message_Flow';
        recs.add(r);
    }
    if (a.masterlabel.equals('assetplanningbasics_1')) {
        r = new Recommendation();
        r.name = 'Lower Rate Product Available';
        r.Description = 'Would You Like to Know More?';
        r.Category__c = 'Products';
        r.Sub_Category__c = 'Low Interest Products';
        r.AcceptanceLabel ='Yes, Please';
        r.RejectionLabel = 'No, I am OK';
        r.imageId = a.id;
        r.actionreference = 'Simple_Message_Flow';
        recs.add(r);
    }

    
}

upsert recs;
