import { LightningElement, api, track } from 'lwc';

export default class ProjectDetailLWC extends LightningElement {
    @api project;
    @api emissions;
    @api offsets;

    // Calculated Carbon Balance
    get carbonBalance() {
        const totalEmissions = this.project?.Target_Emission__c || 0;
        const totalOffsets = this.project?.Emission_Covered__c || 0;
        return totalEmissions - totalOffsets;
    }

    // Columns for emissions table
    emissionColumns = [
        { label: 'Activity Type', fieldName: 'Activity_Type__c' },
        { label: 'Quantity', fieldName: 'Quantity__c', type: 'number' },
        { label: 'Estimated Emission', fieldName: 'Estimated_Emission__c', type: 'number' },
        { label: 'Date', fieldName: 'Date__c', type: 'date' }
    ];

    // Columns for offsets table
    offsetColumns = [
        { label: 'Type', fieldName: 'Type__c' },
        { label: 'Amount', fieldName: 'Amount__c', type: 'number' },
        { label: 'Provider', fieldName: 'Provider__c' },
        { label: 'Date', fieldName: 'Date__c', type: 'date' }
    ];
}
