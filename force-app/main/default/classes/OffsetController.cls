public with sharing class OffsetController {
    public Offset__c offset { get; set; }
    public Id projectId { get; set; }

    public OffsetController() {
        Id offsetId = ApexPages.currentPage().getParameters().get('id');
        offset = [SELECT Id, Name, Amount__c, Type__c, Provider__c, Date__c, Project__c
                  FROM Offset__c
                  WHERE Id = :offsetId];
        projectId = offset.Project__c;
    }

    public PageReference saveOffset() {
        update offset;
        return new PageReference('/apex/ProjectDetail?id=' + projectId);
    }
    public PageReference cancel() {
    return new PageReference('/apex/ProjectDetail?id=' + projectId);
}
}
