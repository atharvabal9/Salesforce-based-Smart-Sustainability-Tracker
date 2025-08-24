@IsTest
public class TestProject {

    // Helper to create a Project
    private static Project__c createProject() {
        Project__c p = new Project__c(
            Name = 'Test Project',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(30),
            Target_Emission__c = 1000,
            Status__c = 'Planned' // required picklist
        );
        insert p;
        return p;
    }

    // Helper to create EmissionFactor
    private static Emission_Factor__c createFactor(Decimal value) {
        Emission_Factor__c factor = new Emission_Factor__c(
            Name = 'Test Factor',
            Category__c = 'Travel',
            Unit__c = 'kg CO2e/mile', // ≤ 15 chars
            Value__c = value
        );
        insert factor;
        return factor;
    }

    // Helper to create Emission
    private static Emission__c createEmission(Project__c project, Decimal quantity, Decimal factorValue) {
        Emission_Factor__c factor = createFactor(factorValue);

        Emission__c emi = new Emission__c(
            Project__c = project.Id,
            Activity_Type__c = 'Travel',
            Quantity__c = quantity,
            Emission_Factor__c = factor.Id,
            Date__c = Date.today()
        );
        insert emi; // Trigger calculates Estimated_Emission__c automatically
        return emi;
    }

    // Helper to create Offset
    private static Offset__c createOffset(Project__c project, Decimal amount) {
        Offset__c offset = new Offset__c(
            Project__c = project.Id,
            Type__c = 'Tree Planting',
            Amount__c = amount,
            Date__c = Date.today()
        );
        insert offset;
        return offset;
    }

    // Test Emission Calculator and Trigger
    @IsTest
    static void testEmissionCalculatorAndTrigger() {
        Project__c project = createProject();

        // Insert emissions (trigger calculates Estimated_Emission__c)
        Emission__c emi1 = createEmission(project, 100, 2); // 100*2=200
        Emission__c emi2 = createEmission(project, 50, 3);  // 50*3=150

        Test.startTest();
        // Update one emission to test after update trigger
        emi1.Quantity__c = 120;
        update emi1;
        Test.stopTest();

        // Verify values
        List<Emission__c> emissionsToCalc = [SELECT Quantity__c, Estimated_Emission__c FROM Emission__c WHERE Project__c = :project.Id ORDER BY Quantity__c DESC];
        System.assertEquals(120*2, emissionsToCalc[0].Estimated_Emission__c); // updated
        System.assertEquals(150, emissionsToCalc[1].Estimated_Emission__c);   // unchanged

        // Verify project totals updated
        Project__c updatedProject = [SELECT Target_Emission__c, Emission_Covered__c FROM Project__c WHERE Id = :project.Id];
        System.assertNotEquals(null, updatedProject.Target_Emission__c);
    }

    // Test Project Controller (VF page)
    @IsTest
    static void testProjectController() {
        Project__c project = createProject();
        createEmission(project, 100, 2);
        createOffset(project, 50);

        // Simulate VF page parameters
        Test.setCurrentPage(Page.ProjectDetail);
        ApexPages.currentPage().getParameters().put('id', project.Id);

        Test.startTest();
        ProjectController controller = new ProjectController();
        Test.stopTest();

        System.assertEquals(project.Id, controller.project.Id);
        System.assert(controller.totalEstimatedEmissions > 0);
        System.assert(controller.totalOffsets > 0);
        System.assert(controller.carbonBalance != null);
    }
}
