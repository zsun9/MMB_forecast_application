clear all; clc
objective_model = "IN10";
target_copy_model = "DNGS15";


p.vintage = ["20010214","20010512","20010815","20011114","20080807","20081110","20090210","20090512","20200211","20200512"];
p.scenario = ["s1","s2","s3","s4"];


p.path.root = convertCharsToStrings(pwd);
p.path.estimations = p.path.root + "\\estimations";
cd(p.path.root)

for ii = 1:length(p.vintage)
    vintage= p.vintage(ii);
    for kk = 1:length(p.scenario) 
        scenario = p.scenario(kk);
        cd(p.path.root)

        t.name.objective_modelworkingpath = objective_model + "_" + strrep(vintage, "-", "") + "_" + scenario;
        t.name.targetcopyworkingpath = target_copy_model + "_" + strrep(vintage, "-", "") + "_" + scenario;
        t.path.objective_modelworking = p.path.estimations + "\\" + t.name.objective_modelworkingpath;
        t.path.targetcopyworking = p.path.estimations + "\\" + t.name.targetcopyworkingpath;

        cd(t.path.objective_modelworking);

        fname =    strcat(objective_model,".json");
        stru.objective_model = jsondecode(fileread(fname));

        cd(t.path.targetcopyworking);

        fname =     strcat(target_copy_model,".json");
        stru.target_copy_model = jsondecode(fileread(fname));   

        %adjusted_gdp =  stru.objective_model.forecast.gdp + (stru.target_copy_model.forecast.gdp(1) - stru.objective_model.forecast.gdp(1));
        adjusted_gdp =   stru.objective_model.forecast.gdp;
        adjusted_gdp(1) = stru.target_copy_model.forecast.gdp(1);

        adjstruc = stru.objective_model;
        adjstruc.forecast.gdp = adjusted_gdp;

        cd(p.path.estimations)
        eval(strcat("mkdir", " " ,objective_model,  "_" ,strrep(vintage, "-", ""), "_" , scenario, "_adjustedgdp"))
        cd(p.path.estimations + "\\" + strcat(objective_model,  "_" ,strrep(vintage, "-", ""), "_" , scenario, "_adjustedgdp"));
            JSONOutput = jsonencode(adjstruc);
            JSONFile = fopen(objective_model + ".json",'w');
            fwrite(JSONFile, JSONOutput, 'char');
            fclose(JSONFile);
        cd(p.path.root);
    end
end