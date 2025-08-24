public with sharing class EmissionController {
    public Emission__c emission { get; set; }
    public Id projectId { get; set; }

    public EmissionController() {
        Id emissionId = ApexPages.currentPage().getParameters().get('id');
        emission = [SELECT Id, Name, Activity_Type__c, Quantity__c, Unit__c,
                           Estimated_Emission__c, Actual_Emission__c, Date__c, Project__c
                    FROM Emission__c
                    WHERE Id = :emissionId];
        projectId = emission.Project__c;
    }

    public PageReference saveEmission() {
        update emission;
        return new PageReference('/apex/ProjectDetail?id=' + projectId);
    }
    public PageReference cancel() {
    return new PageReference('/apex/ProjectDetail?id=' + projectId);
}
}
