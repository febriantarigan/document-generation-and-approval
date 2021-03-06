@istest
public class PC_Roche_TxtFileGeneratorHandlerTest {
	 @testSetup 
    static void setup() {
        Id accPatientRT = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Patient').getRecordTypeId();
        Account acc = new Account(Name='Test Account', RecordTypeId =accPatientRT, PC_Roche_Affiliate__c='TW');
        insert acc;
        PatientConnect__PC_Engagement_Program__c engProg = new PatientConnect__PC_Engagement_Program__c(Name='PSP TW', PatientConnect__PC_Program_Code__c='TWEP1',PC_Roche_Affiliate__c='TW',PatientConnect__PC_Active__c=true);
        insert engProg;
        Id caseProgramRT = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Program').getRecordTypeId();
        PC_Roche_Scheme__c scheme = new PC_Roche_Scheme__c(Name='TW Perjeta Scheme',PC_Roche_MAP_Reference__c='MAP-123',PC_Roche_Affiliate__c='TW', PC_Roche_Units__c='mg');
        insert scheme;
        Case cs = new Case(Account = acc, RecordTypeId = caseProgramRT,Status='In Treatment', PatientConnect__PC_Engagement_Program__c=engProg.id, PC_Roche_Active_Scheme__c=scheme.id);
        insert cs;
        //brand 2 free
        PatientConnect__PC_Program_Coverage__c progCoverage = new PatientConnect__PC_Program_Coverage__c(PC_Roche_Scheme__c=scheme.id,PatientConnect__PC_Coverage_Type__c='FOC',PatientConnect__PC_Program__c=cs.id);
        insert progCoverage;
        PC_Roche_Cycle__c cycle = new PC_Roche_Cycle__c(PC_Roche_Brand_1__c='Kadcyla',PC_Roche_Brand_1_Type__c='Paid', PC_Roche_Brand_2__c='Kadcyla',PC_Roche_Brand_2_Type__c='Free',PC_Roche_Program_Coverage__c=progCoverage.id,PC_Roche_Brand_2_Free_Strength_1__c=100,PC_Roche_Brand_2_Free_Strength_2__c=120,PC_Roche_Brand_2_Free_Strength_3__c=140);
        insert cycle;
        Id docManualUploadRT = Schema.SObjectType.PatientConnect__PC_Document__c.getRecordTypeInfosByName().get('Manual Upload').getRecordTypeId();
        PatientConnect__PC_Document__c document = new PatientConnect__PC_Document__c(PC_Roche_Scheme__c=scheme.id,RecordTypeId=docManualUploadRT,PC_Roche_Affiliate__c='TW',PatientConnect__PC_Document_Category__c='FOC Application Form');
        insert document;
        PatientConnect__PC_Document_Log__c documentLog = new PatientConnect__PC_Document_Log__c(PatientConnect__PC_Document__c=document.id, PC_Roche_Cycle_Lookup__c=cycle.id, PatientConnect__PC_Account__c=acc.id, PatientConnect__PC_Coverage__c=progCoverage.id, PatientConnect__PC_Program__c=cs.id);
        insert documentLog;
        //brand 1 and brand 2 free
        PC_Roche_Cycle__c cycle2 = new PC_Roche_Cycle__c(PC_Roche_Brand_1__c='Kadcyla',PC_Roche_Brand_1_Type__c='Free', PC_Roche_Brand_1_Free_Unit_1__c=1, PC_Roche_Brand_2__c='Kadcyla',PC_Roche_Brand_2_Type__c='Free', PC_Roche_Brand_2_Free_Unit_1__c=1, PC_Roche_Program_Coverage__c=progCoverage.id, PC_Roche_Brand_1_Free_Strength_1__c=100,PC_Roche_Brand_1_Free_Strength_2__c=120,PC_Roche_Brand_1_Free_Strength_3__c=140, PC_Roche_Brand_2_Free_Strength_1__c=100,PC_Roche_Brand_2_Free_Strength_2__c=120,PC_Roche_Brand_2_Free_Strength_3__c=140);
        insert cycle2;
        PatientConnect__PC_Document__c document2 = new PatientConnect__PC_Document__c(PC_Roche_Scheme__c=scheme.id,RecordTypeId=docManualUploadRT,PC_Roche_Affiliate__c='TW',PatientConnect__PC_Document_Category__c='FOC Application Form');
        insert document2;
        PatientConnect__PC_Document_Log__c documentLog2 = new PatientConnect__PC_Document_Log__c(PatientConnect__PC_Document__c=document2.id, PC_Roche_Cycle_Lookup__c=cycle2.id, PatientConnect__PC_Account__c=acc.id, PatientConnect__PC_Coverage__c=progCoverage.id, PatientConnect__PC_Program__c=cs.id);
        insert documentLog2;
        //brand 1 free
        PC_Roche_Cycle__c cycle3 = new PC_Roche_Cycle__c(PC_Roche_Brand_1__c='Kadcyla',PC_Roche_Brand_1_Type__c='Free',PC_Roche_Program_Coverage__c=progCoverage.id, PC_Roche_Brand_1_Free_Unit_1__c=1, PC_Roche_Brand_1_Free_Strength_1__c=100,PC_Roche_Brand_1_Free_Strength_2__c=120,PC_Roche_Brand_1_Free_Strength_3__c=140);
        insert cycle3;
        PatientConnect__PC_Document__c document3 = new PatientConnect__PC_Document__c(PC_Roche_Scheme__c=scheme.id,RecordTypeId=docManualUploadRT,PC_Roche_Affiliate__c='TW',PatientConnect__PC_Document_Category__c='FOC Application Form');
        insert document3;
        PatientConnect__PC_Document_Log__c documentLog3 = new PatientConnect__PC_Document_Log__c(PatientConnect__PC_Document__c=document3.id, PC_Roche_Cycle_Lookup__c=cycle3.id, PatientConnect__PC_Account__c=acc.id, PatientConnect__PC_Coverage__c=progCoverage.id, PatientConnect__PC_Program__c=cs.id);
        insert documentLog3;
        
        Attachment att = new Attachment();
		Blob bodyBlob =  Blob.valueOf('Test File Upload');
		att.Body = bodyBlob;
        att.Name = 'testMe';
        att.ContentType = 'text/plain';
        att.parentId=document.id;
        insert att;
        
        Attachment att2 = new Attachment();
		bodyBlob =  Blob.valueOf('Test File Upload2');
		att2.Body = bodyBlob;
        att2.Name = 'testMe';
        att2.ContentType = 'text/plain';
        att2.parentId=document2.id;
        insert att2;
        
        Attachment att3 = new Attachment();
		bodyBlob =  Blob.valueOf('Test File Upload2');
		att3.Body = bodyBlob;
        att3.Name = 'testMe';
        att3.ContentType = 'text/plain';
        att3.parentId=document3.id;
        insert att3;
    }
    @isTest public static void Strength1NotNull(){
        Set<Id> setOfCycleIds = new Set<Id>();
        for(PC_Roche_Cycle__c cyc : [SELECT Id FROM PC_Roche_Cycle__c]){
            setOfCycleIds.add(cyc.id);
        }
        
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new PC_Roche_FileUploaderHandlerMock());
       	 	//HttpResponse res = PC_Roche_FileUploaderHandler.testResponse();
       	 	PC_Roche_TxtFileGeneratorBatch FUB = new PC_Roche_TxtFileGeneratorBatch(setOfCycleIds);
        	DataBase.executeBatch(FUB);
        test.stopTest();
    } 
    
    @isTest public static void testMock(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PC_Roche_FileUploaderHandlerMock());
         // Create File Request
        Http h = new Http();        
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart&supportsTeamDrives=true');
        req1.setMethod('POST');
        req1.setBody('{"name":"test file","id":"10D7OsUFVariT5Ghe3CYV7akLjLZa00PY","mimeType":"application/pdf",parents":["1KGRBDAbYvcHZoKz9H76IRA8dy2QblhFu"],"teamDriveId":"0AGj2ssL2WNiVUk9PVA"}');
        HttpResponse res1 = h.send(req1);
        System.assertEquals('{"name":"test file","id":"10D7OsUFVariT5Ghe3CYV7akLjLZa00PY","mimeType":"application/pdf",parents":["1KGRBDAbYvcHZoKz9H76IRA8dy2QblhFu"],"teamDriveId":"0AGj2ssL2WNiVUk9PVA"}', res1.getBody());
    	test.stopTest();
    } 
}