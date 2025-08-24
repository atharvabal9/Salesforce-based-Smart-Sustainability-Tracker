public with sharing class EmissionCalculator {
    
    // Method to calculate estimated emissions for a list of Emission__c records
    public static void calculateEmissions(List<Emission__c> emissions) {
        // Collect all EmissionFactor IDs to query once
        Set<Id> factorIds = new Set<Id>();
        for (Emission__c emi : emissions) {
            if (emi.Emission_Factor__c != null) {
                factorIds.add(emi.Emission_Factor__c);
            }
        } 
        
        // Query relevant factors
        Map<Id, Emission_Factor__c> factorMap = new Map<Id, Emission_Factor__c>(
            [SELECT Id, Value__c FROM Emission_Factor__c WHERE Id IN :factorIds]
        );
        
        // Perform calculation
        for (Emission__c emi : emissions) {
            if (emi.Quantity__c != null && emi.Emission_Factor__c != null) {
                Emission_Factor__c factor = factorMap.get(emi.Emission_Factor__c);
                if (factor != null) {
                    emi.Estimated_Emission__c = emi.Quantity__c * factor.Value__c;
                }
            }
        }
    }
}
