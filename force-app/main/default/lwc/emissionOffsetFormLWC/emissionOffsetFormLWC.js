import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveEmission from '@salesforce/apex/ProjectController.saveEmission';
import saveOffset from '@salesforce/apex/ProjectController.saveOffset';

export default class EmissionOffsetFormLWC extends LightningElement {
    @api recordId; // Project Id
    type = 'Emission'; // 'Emission' or 'Offset'
    quantity;
    activityType;
    emissionType;
    amount;
    offsetType;
    provider;

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {
        if (this.type === 'Emission') {
            saveEmission({
                projectId: this.recordId,
                quantity: this.quantity,
                activityType: this.activityType
            })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Emission added',
                        variant: 'success'
                    })
                );
            });
        } else {
            saveOffset({
                projectId: this.recordId,
                amount: this.amount,
                offsetType: this.offsetType,
                provider: this.provider
            })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Offset added',
                        variant: 'success'
                    })
                );
            });
        }
    }
}
