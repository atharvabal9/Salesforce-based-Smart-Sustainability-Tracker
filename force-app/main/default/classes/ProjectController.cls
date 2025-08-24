public with sharing class ProjectController {
    public Project__c project { get; set; }
    public List<Emission__c> emissions { get; set; }
    public List<Offset__c> offsets { get; set; }
    public Decimal totalEstimatedEmissions { get; set; }
    public Decimal totalOffsets { get; set; }
    public Decimal carbonBalance { get; set; }

    public ProjectController() {
        // Get project Id from URL
        Id projectId = ApexPages.currentPage().getParameters().get('id');
        project = [SELECT Id, Name,  Target_Emission__c, Emission_Covered__c
                   FROM Project__c WHERE Id = :projectId];

        // Query emissions and offsets for this project
        emissions = [SELECT Id, Activity_Type__c, Quantity__c, Estimated_Emission__c, Date__c
                     FROM Emission__c WHERE Project__c = :project.Id];

        offsets = [SELECT Id, Type__c, Amount__c, Date__c
                   FROM Offset__c WHERE Project__c = :project.Id];

        // Calculate totals
        totalEstimatedEmissions = 0;
        for(Emission__c e : emissions) {
            if(e.Estimated_Emission__c != null) totalEstimatedEmissions += e.Estimated_Emission__c;
        }

        totalOffsets = 0;
        for(Offset__c o : offsets) {
            if(o.Amount__c != null) totalOffsets += o.Amount__c;
        }

        // Carbon balance
        carbonBalance = project.Target_Emission__c != null && project.Emission_Covered__c != null
                        ? project.Target_Emission__c - project.Emission_Covered__c
                        : 0;
    }
    @AuraEnabled
    public static Id saveEmission(Emission__c emission) {
        try {
            insert emission;
            return emission.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving emission: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static Id saveOffset(Offset__c offset) {
        try {
            insert offset;
            return offset.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving offset: ' + e.getMessage());
        }
    }
}
