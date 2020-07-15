global class PackageScripts {

    
    /**
     * Execute the installation scripts for the Customer Implementation
     */
    global static void install() {
        new PackageScripts.Install().run();
    }


    global class Install implements Framework.Scriptable {
        global void run() {
            Framework.Log.push(PackageScripts.Install.class.getName(),'run');

            new AppConfig().run();
            new Register().run();
            new Rollups().run();

            Framework.Log.pop();
        }
    }


    global class AppConfig implements Framework.Scriptable {
        global void run() {
            Framework.Log.push(PackageScripts.AppConfig.class.getName(),'run');

            Framework.Log.pop();
        }
    }


    global class Register implements Framework.Scriptable {
        global void run() {

            //------------- Begin: Registering App-------------------//
            Framework.RegisteredApp ev = new Framework.RegisteredApp();
            ev.namespace = 'TriggerOverride';
            ev.name = 'Custom trigger functionality';
            ev.description = 'Custom trigger functionality';
            ev.owner = 'IA Corp';
            ev.isManaged = false;
            ev.isEnabled = true;
            ev.installClass = PackageScripts.Install.class.getName();
            
            Framework.Config.push(ev);

            
            //------------- Begin: Registering objects (Alphabetical Order)-------------------//
            Framework.RegisteredObject[] regObjects = new List<Framework.RegisteredObject>();
            
            Framework.RegisteredObject att = new Framework.RegisteredObject();
            att.sObjectName = Framework.SchemaService.getDescribe(Account.SObjectType).getName();
            att.apexClass = AccountsOverride.class.getName();
            att.namespace = 'TriggerOverride';
            att.isEnabled = true;
            att.isStandard = true;
            att.triggersEnabled = true;
            att.soqlLimit = String.valueOf(2000);
            att.soqlOrderBy = SObjectType.Account.fields.Name.getName() + ' ASC';
            regObjects.add(att);
            
            Framework.Config.push(regObjects);


            //------------- Begin: Routing Rules creation (Alphabetical Order)--------------------//
            Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
            
            Framework.RoutingRule accPermission = new Framework.RoutingRule();
            accPermission.apexClass = AccountsOverride.class.getName();
            accPermission.namespace = 'TriggerOverride';
            accPermission.isEnabled = true;
            accPermission.sObjectName = SObjectType.Account.getName();
            accPermission.executionOrder = 0;
            rules.add(accPermission);
            
            Framework.Config.push(rules);
        }
    }

    global class Rollups implements Framework.Scriptable {
        global void run() {
            Framework.Log.push(PackageScripts.class.getName(),'.Scripts.createRollups');
            Framework.RollupSummaryField[] rsfs = new List<Framework.RollupSummaryField>();

            Framework.Config.push(rsfs);
            Framework.Log.pop();
        }
    }

}