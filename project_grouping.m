function project_grouping()

clc;
close all;
global treatments nm xls ps_group;

% List of treatments, a key to filter by, and the treatment priority (lower
% numbers are more expensive treatments).
treatments = {
    'PCC Lane Replacement',2,1,[255 0 0]/255,2;
    'CRCP Lane Replacement',2,1,[255 0 0]/255,2;
    'PCC overlay',2,1,[255 0 0]/255,2;
    'Grind/Replace slabs',2,2,[128 0 0]/255,2;
    'Grind PCC for Smoothness',2,3,[255 192 0]/255,2;
    'Groove PCC Pavement',2,3,[255 192 0]/255,2;
    'Slab Replacement',2,3,[128 128 128]/255,2;
    'Slab Replacement with Pre-Cast',2,3,[128 128 128]/255,2;
    'Slab Replacement with Asphalt',2,3,[128 128 128]/255,2
    'Crack Seat and Overlay',2,1,[112 48 160]/255,1;
    'Digouts',1,6,[148 138 84]/255,1;
    'Seal Coat',1,5,[255 255 0]/255,1;
    'Fog Seal',1,5,[255 255 0]/255,1;
    'Chip Seal',1,5,[255 255 0]/255,1;
    'Microsurfacing',1,5,[255 255 0]/255,1;
    'HMA Thin Overlay',1,4,[0 176 240]/255,1;
    'HMA Medium Overlay',1,3,[0 112 192]/255,1;
    'Cold In-Place Recycling',1,2,[146 208 80]/255,1;
    'Full Depth Reclamation',1,1,[0 176 80]/255,1;
    'HMA Thick Overlay',1,1,[0 32 96]/255,1;
};

budgets = {
    'CAPM',2000000;
    'Corrective Maintenance',500000;
    'Other',0;
    'Preventive Maintenance',500000;
    'Rehab',5000000;
};

% cm = hsv(size(treatments,1));
% for i = 1:size(treatments,1)
%     treatments{i,4} = cm(i,:);
% end
% clear i cm;
         
% nm_columns = {
%     'District';
%     'Beg ODM';
%     'End ODM';
%     'Pavement Type';
%     'Year of Last Treatment';
%     'County';
%     'Route';
%     'RS';
%     'BPP';
%     'Beg PM';
%     'BPS';
%     'EPP';
%     'End PM';
%     'EPS';
%     'Dir';
%     'Dir(L/R)';
%     'Lane';
%     'Total Lane Miles';
%     'Route Break Ahead';
%     'Route Break Back';
%     'IRI Avg (in/mi)';
%     'Cracking - PCCP 3rd Stage (%)';
%     'Cracking - HMA Wheelpath (%)';
% };
% 
nm_columns = {
    'District';
    'Beg ODM';
    'End ODM';
    'Pavement Type';
    'County';
    'Route';
    'Route Sfx';
    'BPP';
    'Beg PM';
    'BPS';
    'EPP';
    'End PM';
    'EPS';
    'Dir';
    'Lane';
    'Total Lane Miles';
    'Beg Bdry Type';
    'End Bdry Type';
};

wp_columns = {
    'Year';
    'Plan Year';
    'EA';
    'CA PROJECTID';
    'County';
    'Route';
    'RS';
    'BPP';
    'Beg PM';
    'BPS';
    'EPP';
    'End PM';
    'EPS';
    'Dir';
    'Lane';
    'Beg ODM';
    'End ODM';
    'Length';
    'Treatment';
    'Budget Group';
    'Estimated Cost';
    'MWP Project Status';
    'Preservation Benefit/Cost';
    'IRI Benefit/Cost';
    'IRI/User Costs Benefit /Cost';
    'IRI/Traffic Weighted Benefit/Cost';
    'Benefit IRI/Traffic/Preservation/cost';
    'CA GHG Benefit/Cost';
    'NHS';
    'Total Lane Miles';
    'PMS Section #';
    'Pavement Type'
};

loc_columns = {
    'Plan_Year';
    'Year';
    'Route';
    'Dir';
    'Lane';
    'Beg_ODM';
    'End_ODM';
    'Treatment';
    'Estimated_Cost';
    'MWP_Project_Status';
    'Total_Lane_Miles';
};

% fname = 'Z:\Projects\3.9 Asset Inventory QA\Grouping\Network Master Data(3).xls';
% mname = strrep(strrep(fname,'.xlsx','.mat'),'.xls','.mat');
% if exist(mname,'file')
%     nm = load(mname,'nm');
%     nm = nm.nm;
% else
%     [~,~,nmf] = xlsread(fname,1,'1:1');
%     cols = cellfun(@(x) find(strcmpi(x,nmf(1,:)))-1,nm_columns);
%     nmf = strrep(regexprep(strrep(strrep(nm_columns,'/',' '),'#','No'),'[ %-]*','_'),'Dir(L_R)','RL');
%     nmf = regexprep(regexprep(regexprep(nmf,'[(].*[)]',''),'[_]+$',''),'[_]+','_');
%     c = char('A'+cols(1));
%     [~,~,nm] = xlsread(fname,1,[c ':' c]);
%     nm(cellfun(@(x) isnan(x(1)),nm(:,1)),:) = [];
%     r = size(nm,1);
%     nm = [];
%     for i=1:length(cols)
%         if cols(i) > 25
%             c = [char('A'+floor(cols(i)/26)-1) char('A'+mod(cols(i),26))];
%         else
%             c = char('A'+cols(i));
%         end
%         disp(c)
%         [~,~,nm.(nmf{i})] = xlsread(fname,1,[c '2:' c num2str(r)]);
%     end
%     nm.District = cellfun(@(x) str2double(x(10:11)),nm.District);
%     nm.Beg_ODM = cell2mat(nm.Beg_ODM);
%     nm.End_ODM = cell2mat(nm.End_ODM);
%     nm.Route = cellfun(@(x,y) [x cleanstr(y)],nm.Route,nm.RS,'UniformOutput',false);
%     nm.Beg_PM = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],nm.BPP,nm.Beg_PM,nm.BPS,'UniformOutput',false);
%     nm.End_PM = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],nm.EPP,nm.End_PM,nm.EPS,'UniformOutput',false);
%     nm.Pavement_Type = cellfun(@(x) x(1),nm.Pavement_Type,'UniformOutput',false);
%     nm.Year_of_Last_Treatment = cell2mat(nm.Year_of_Last_Treatment);
%     nm.Lane = cellfun(@(x) str2double(strrep(x,'All','0')),nm.Lane);
%     nm.Route_ID = cellfun(@(x,y) regexprep(strrep([x y(1)],'B','R'),'^[0]*',''),nm.Route,nm.RL,'UniformOutput',false);
%     nm.Total_Lane_Miles = cell2mat(nm.Total_Lane_Miles);
%     nm.Route_Break_Ahead = cellfun(@(x) strcmp(x,'Yes'),nm.Route_Break_Ahead);
%     nm.Route_Break_Back = cellfun(@(x) strcmp(x,'Yes'),nm.Route_Break_Back);
%     nm.IRI_Avg = cell2mat(nm.IRI_Avg);
%     nm.Cracking_PCCP_3rd_Stage = cell2mat(nm.Cracking_PCCP_3rd_Stage);
%     nm.Cracking_HMA_Wheelpath = cell2mat(nm.Cracking_HMA_Wheelpath);
%     nm = rmfield(nm,{'RS','BPP','BPS','EPP','EPS'});
%     save(mname,'nm');
% end
% clear mname nmf cols i c r mask nm_columns;

fname = 'Z:\Projects\3.9 Asset Inventory QA\Grouping\PaveM Management Sections.xlsx';
mname = strrep(strrep(fname,'.xlsx','.mat'),'.xls','.mat');
if exist(mname,'file')
    nm = load(mname,'nm');
    nm = nm.nm;
else
    [~,~,xlsx] = xlsread(fname,1);
    cols = cellfun(@(x) find(strcmpi(x,xls(1,:))),nm_columns);
    xlsx = xlsx(:,cols);
    nmf = regexprep(strrep(strrep(nm_columns,'/',' '),'#','No'),'[ %-]*','_');
    nm = [];
    for i = 1:length(nmf)
        nm.(nmf{i}) = xlsx(2:end,i);
    end
    nm.District = cellfun(@(x) str2double(x(10:11)),nm.District);
    nm.Beg_ODM = cell2mat(nm.Beg_ODM);
    nm.End_ODM = cell2mat(nm.End_ODM);
    nm.Route = cellfun(@(x,y) [x cleanstr(y)],nm.Route,nm.Route_Sfx,'UniformOutput',false);
    nm.Beg_PM = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],nm.BPP,nm.Beg_PM,nm.BPS,'UniformOutput',false);
    nm.End_PM = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],nm.EPP,nm.End_PM,nm.EPS,'UniformOutput',false);
    nm.Pavement_Type = cellfun(@(x) x(1),nm.Pavement_Type,'UniformOutput',false);
    nm.Lane = cellfun(@(x) str2double(strrep(x,'All','0')),nm.Lane);
    nm.Total_Lane_Miles = cell2mat(nm.Total_Lane_Miles);
    nm.Route_Break_Ahead = cellfun(@(x) strcmp(x,'RouteSegmentEnd'),nm.End_Bdry_Type);
    nm.Route_Break_Back = cellfun(@(x) strcmp(x,'RouteSegmentStart'),nm.Beg_Bdry_Type);
    nm = rmfield(nm,{'Route_Sfx','BPP','BPS','EPP','EPS'});
    save('C:\Users\Jeremy Lea\Desktop\junk.mat','nm','-v7'); % Matlab doesn't save on Z?
    movefile('C:\Users\Jeremy Lea\Desktop\junk.mat',mname);
end
clear mname nmf cols xlsx nm_columns;

% Read PaveM scenario results, saved as XLS, in and convert to a struct.
fname = 'Z:\Projects\3.9 Asset Inventory QA\Grouping\Work Plan Results #1259.xls';
%fname = 'C:\Users\Jeremy Lea\Downloads\Work Plan Results #1223.xls';
ps_group{1} = strrep(strrep(fname,'.xlsx','.ps'),'.xls','.ps');
ps_group{2} = strrep(ps_group{1},'.ps','-seg.ps');
if exist(ps_group{1},'file')
    delete(ps_group{1});
end
if exist(ps_group{2},'file')
    delete(ps_group{2});
end
create_legend();
print(gcf,'-dpsc2',ps_group{2},'-append');
close gcf;

[~,~,xls] = xlsread(fname);
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),wp_columns);
xls = xls(:,cols);
xls(1,:) = regexprep(strrep(strrep(xls(1,:),'/',' '),'#','No'),'[ ]*','_');
% Convert lane numbers back to integers.
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'Lane'});
xls(2:end,cols) = cellfun(@(x) str2double(strrep(x,'All','0')),xls(2:end,cols),'UniformOutput',false);
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'Route','RS'});
xls(2:end,cols(1)) = cellfun(@(x,y) [x cleanstr(y)],xls(2:end,cols(1)),xls(2:end,cols(2)),'UniformOutput',false);
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'BPP','Beg_PM','BPS'});
xls(2:end,cols(2)) = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],xls(2:end,cols(1)),xls(2:end,cols(2)),xls(2:end,cols(3)),'UniformOutput',false);
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'EPP','End_PM','EPS'});
xls(2:end,cols(2)) = cellfun(@(x,y,z) [cleanstr(x) num2str(y,'%0.3f') cleanstr(z)],xls(2:end,cols(1)),xls(2:end,cols(2)),xls(2:end,cols(3)),'UniformOutput',false);
cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'RS','BPP','BPS','EPP','EPS'});
xls(:,cols) = [];
%cols = cellfun(@(x) find(strcmp(x,xls(1,:))),{'Route'});
%xls(1+find(~strcmp('060',xls(2:end,cols))),:) = [];
%xls(1+find(cell2mat(xls(2:end,6)) > 4),:) = [];
% Create a copy to work with.
new = xls;
xls = cell2struct(xls(2:end,:),xls(1,:),2);
cols = cellfun(@(x) find(strcmp(x,new(1,:))),loc_columns);
new = new(:,cols);
new{1,end+1} = 'line';
cols = cellfun(@(x) find(strcmp(x,new(1,:))),{'Route','Dir','Plan_Year','Lane','Beg_ODM'});
new = cell2struct(new(2:end,:),new(1,:),2);
%new(strcmp('Scenario Recommended',{new.MWP_Project_Status})) = [];
% Setup the treatments without the color of the money
for i = 1:length(new)
    new(i).line = i;
    new(i).Treatment = regexprep(new(i).Treatment,' - .*','');
    % convert treatment to an index
    if strcmp('Scenario Recommended',new(i).MWP_Project_Status)
        new(i).Treatment = find(strcmp(new(i).Treatment,treatments(:,1)));
    end
end
new(arrayfun(@(x) ~isnumeric(x.Treatment) && ~isempty(regexp(x.Treatment,'^(Non-Mainline Related|Replace PCC approach slab|Joint Sealing)','once')),new)) = [];
new(arrayfun(@(x) x.Beg_ODM == x.End_ODM,new)) = [];
[~,ord] = sortrows(struct2cell(new)',cols);
new = new(ord);
clear ord cols wp_columns;

t = unique({xls.Treatment});
for i = 1:length(t)
    j = find(strcmp(t{i},{xls.Treatment}),1,'first');
    k = strcmp(regexprep(t{i},' - .*',''),treatments(:,1));
    if ~any(k)
        continue;
    end
    treatments{k,6} = xls(j).Budget_Group;
    treatments{k,7} = budgets{strcmp(xls(j).Budget_Group,budgets(:,1)),2};
end
clear i t j k;

% We do merging in three phases
% 1. We make the "thickest" treatment apply across all lanes
% 2. We merge longitudinally
%   a. We downgrade or upgrade treatments on small segments
%   b. We check for some future years
% 3. We fix up the treatments at the end
%

% Now loop over unique routes and directions
final_seg = [];
final_loc = [];
rte = unique(nm.Route);
for ir = 1:length(rte)
    %if ~strcmp(rte{ir},'101')
    %    continue;
    %end
    % Get a mask of all the segments for this route ID.
    % Get unique directions for this route (normally only one).
    dirs = unique(nm.Dir(strcmp(rte{ir},nm.Route)));
    for id = 1:length(dirs)
        % get all the network master segments
        idx = find(strcmp(rte{ir},nm.Route) & strcmp(dirs{id},nm.Dir));
        % now figure out any route breaks or other hard segments
        odom = sortrows(num2cell([nm.Beg_ODM(idx) nm.End_ODM(idx) idx]));
        [~,ord] = unique(cell2mat(odom(:,1:2)),'rows');
        odom = odom(ord,:);
        for i = 1:size(odom,1)
            odom{i,4} = nm.District(odom{i,3});
            odom(i,5) = nm.County(odom{i,3});
            odom{i,6} = nm.Route_Break_Ahead(odom{i,3});
            odom{i,7} = nm.Route_Break_Back(odom{i,3});
        end
        if size(odom,1) > 1
            split = find([odom{1:end-1,4}] ~= [odom{2:end,4}] | ~strcmp(odom(1:end-1,5),odom(2:end,5))' | [odom{2:end,7}])';
            split = [[1; split+1] [split; size(odom,1)]];
        else
            split = [1 1];
        end
        % now get the projects for this route
        loc = new(strcmp(rte{ir},{new.Route}) & strcmp(dirs{id},{new.Dir}));
        new_seg = [];
        new_loc = new(strcmp(rte{ir},{new.Route}) & strcmp(dirs{id},{new.Dir}) & ~strcmp('Scenario Recommended',{new.MWP_Project_Status}));

        % get the start and end odometers for the segments.
        odm = sort(unique([nm.Beg_ODM(idx)' nm.End_ODM(idx)']));
        odm = sort(unique([odm [loc([loc.Beg_ODM] > odm(1)).Beg_ODM] [loc([loc.End_ODM] < odm(end)).End_ODM]]));
        odm = [odm(1:end-1)' odm(2:end)'];
        odm(:,3) = 0; % lane count
        % Loop over odometers to find max lane number
        for i = 1:size(odm,1)
            % Get all the network master segments that match the start and end
            mask = nm.Beg_ODM(idx) <= odm(i,1) & nm.End_ODM(idx) >= odm(i,2);
            if any(mask)
                odm(i,3) = max(1,max(nm.Lane(idx(mask))));
            end
        end
        for i = 1:length(loc)
            % Get all the treatment segments that match the start and end
            mask = loc(i).Beg_ODM <= odm(:,1) & loc(i).End_ODM >= odm(:,2);
            % get the max lane number over all years
            odm(mask,3) = max(odm(mask,3),loc(i).Lane);
        end
        % get the max lane number and create a map of segments
        msk = zeros(size(odm,1),max(odm(:,3)));
        nln = zeros(size(odm,1),max(odm(:,3)));
        tlm = zeros(size(odm,1),max(odm(:,3)));
        for io = 1:size(odm,1)
            for il = 1:odm(io,3)
                % Get the network master segment that matches the start, end and lane
                mask = nm.Beg_ODM(idx) <= odm(io,1) & nm.End_ODM(idx) >= odm(io,2) & (nm.Lane(idx) == il | nm.Lane(idx) == 0);
                if any(mask)
                    nln(io,il) = idx(mask);
                    if nm.Total_Lane_Miles(nln(io,il)) == 0
                        msk(io,il) = -1;
                    elseif nm.Pavement_Type{nln(io,il)} == 'F'
                        msk(io,il) = 1;
                    elseif nm.Pavement_Type{nln(io,il)} == 'J'
                        msk(io,il) = 2;
                    else
                        msk(io,il) = -1;
                    end
                else
                    msk(io,il) = -1; % XXX work outside of network master
                end
            end
        end
        clear io il mask;
        % Get the total lane_miles from the network master.
        for io = 1:size(odm,1)
            for il = 1:odm(io,3)
                if nln(io,il) ~= 0
                    % Pro-rate lane miles by the length of the segment, in
                    % case the section has been split by a project.  Hopefully
                    % there is gets better below...
                    [jo,~] = find(nln == nln(io,il));
                    tlm(io,il) = nm.Total_Lane_Miles(nln(io,il))*(odm(io,2)-odm(io,1))/(max(odm(jo,2))-min(odm(jo,1)));
                    clear jo;
                end
            end
            clear il;
        end
        % PaveM produces better lane miles in the results from the finest
        % partition.  Use those if they are available.
        for io = 1:size(odm,1)
            % only find exactly matching sections from the results.
            mask = ([loc.Beg_ODM] == odm(io,1)) & ([loc.End_ODM] == odm(io,2));
            for i = find(mask)
                il = 0;
                if loc(i).Lane == 0
                    if odm(io,3) == 1
                        il = 1;
                    end
                else
                    il = loc(i).Lane;
                end
                if il > 0 && abs(loc(i).Total_Lane_Miles-tlm(io,il)) > 0.001
                    if nln(io,il) > 0
                        [jo,jl] = find(nln == nln(io,il));
                        assert(all(jl == il),'Ooops');
                        jo(jo == io) = [];
                        if ~isempty(jo)
                            tlm(jo,il) = tlm(jo,il) - (loc(i).Total_Lane_Miles-tlm(io,il))*tlm(jo,il)/sum(tlm(jo,il));
                            tlm(io,il) = loc(i).Total_Lane_Miles;
                        else
                            % oops, PaveM disagrees on lane miles...
                        end
                    else
                        % project not on network master segmet...
                        %tlm(io,il) = loc(i).Total_Lane_Miles;
                    end
                end
                clear il;
            end
            clear i mask;
        end
        clear io;
        % now slice and dice every project by the odometer grid.
        full = [1:size(odm,1); 1:size(odm,1); ones(1,size(odm,1))]';
        for i = 1:length(loc)
            loc = split_project(loc,i,odm,full,tlm);
        end
        if ~isempty(loc)
            cols = cellfun(@(x) find(strcmp(x,fieldnames(loc))),{'Plan_Year','Lane','Beg_ODM'});
            [~,ord] = sortrows(struct2cell(loc(:))',cols);
            loc = loc(ord);
            clear ord;
        end
        clear i full;

        % now we have these values, we loop over the sub segments doing
        % grouping...
        for i = 1:size(split,1)
            tl = [rte{ir} '-' dirs{id} ' ' odom{split(i,1),5} ' ' nm.Beg_PM{odom{split(i,1),3}} ' to ' nm.End_PM{odom{split(i,2),3}}];
            % copy this route and direction out so we can work on it.
            mask = [loc.Beg_ODM] < odom{split(i,2),2} & [loc.End_ODM] > odom{split(i,1),1};
            % if we have no projects assume this segment wasn't in the
            % analysis and move on...
            % run the grouping
            io = odm(:,1) >= odom{split(i,1),1} & odm(:,2) <= odom{split(i,2),2};
            il = 1:max(odm(io,3));
            [tmp,seg] = group(tl,loc(mask),odm(io,:),msk(io,il),tlm(io,il));
            % We already put the real projects in the results
            tmp(~strcmp('Scenario Recommended',{tmp.MWP_Project_Status})) = [];
            if ~isempty(tmp)
                cols = cellfun(@(x) find(strcmp(x,fieldnames(tmp))),{'Plan_Year','Lane','Beg_ODM'});
                [~,ord] = sortrows(struct2cell(tmp(:))',cols);
                tmp = tmp(ord);
                clear ord;
                new_loc = [new_loc; tmp]; %#ok<AGROW>
            end
            new_seg = [new_seg; seg]; %#ok<AGROW>
            clear tmp seg mask tl io;
        end
        clear i;
        for j = 1:length(new_loc)
            route = regexp(rte{ir},'^([0-9]+)([US]?)$','tokens');
            new_loc(j).Route = route{1}{1};
            new_loc(j).RS = route{1}{2};
            s = find(new_loc(j).Beg_ODM < cell2mat(odom(split(:,2),2)) & new_loc(j).End_ODM > cell2mat(odom(split(:,1),1)));
            new_loc(j).District = num2str(odom{split(s(1),1),4},'%02u');
            new_loc(j).County = odom{split(s(1),1),5};
            io = idx(nm.Beg_ODM(idx) == new_loc(j).Beg_ODM);
            if isempty(io)
                io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.Beg_ODM] == new_loc(j).Beg_ODM,1,'first');
                if isempty(io)
                    io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.End_ODM] == new_loc(j).Beg_ODM,1,'first');
                    pm = xls(io).End_PM;
                else
                    pm = xls(io).Beg_PM;
                end
            else
                pm = nm.Beg_PM{io(1)};
            end
            pm = regexp(pm,'^([A-Z]?)([0-9]+.[0-9]*)([LR]?)$','tokens');
            new_loc(j).BPP = pm{1}{1};
            new_loc(j).Beg_PM = pm{1}{2};
            new_loc(j).BPS = pm{1}{3};
            io = idx(nm.End_ODM(idx) == new_loc(j).End_ODM);
            if isempty(io)
                io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.End_ODM] == new_loc(j).End_ODM,1,'first');
                if isempty(io)
                    io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.Beg_ODM] == new_loc(j).End_ODM,1,'first');
                    pm = xls(io).Beg_PM;
                else
                    pm = xls(io).End_PM;
                end
            else
                pm = nm.End_PM{io(1)};
            end
            pm = regexp(pm,'^([A-Z]?)([0-9]+.[0-9]*)([LR]?)$','tokens');
            new_loc(j).EPP = pm{1}{1};
            new_loc(j).End_PM = pm{1}{2};
            new_loc(j).EPS = pm{1}{3};
            new_loc(j).Budget_Group = xls(find(strcmp(new_loc(j).Treatment,{xls.Treatment}),1,'first')).Budget_Group;
            if ~strcmp('Scenario Recommended',new_loc(j).MWP_Project_Status)
                new_loc(j).EA = xls(new_loc(j).line).EA;
                new_loc(j).CA_PROJECTID = xls(new_loc(j).line).CA_PROJECTID;
            else
                new_loc(j).EA = [new_loc(j).District '-' num2alpha(ir,2) num2alpha(new_loc(j).Plan_Year,1) num2alpha(floor((new_loc(j).Beg_ODM+new_loc(j).End_ODM)/2),2) 'T'];
                new_loc(j).CA_PROJECTID = '';
            end
        end
        for j = 1:length(new_seg)
            route = regexp(rte{ir},'^([0-9]+)([US]?)$','tokens');
            new_seg(j).Route = route{1}{1}; %#ok<AGROW>
            new_seg(j).RS = route{1}{2}; %#ok<AGROW>
            s = find(new_seg(j).Beg_ODM < cell2mat(odom(split(:,2),2)) & new_seg(j).End_ODM > cell2mat(odom(split(:,1),1)));
            new_seg(j).District = num2str(odom{split(s(1),1),4},'%02u'); %#ok<AGROW>
            new_seg(j).County = odom{split(s(1),1),5}; %#ok<AGROW>
            if isempty(new_seg(j).Dir)
                new_seg(j).Dir = dirs{id}; %#ok<AGROW>
            end
            io = idx(nm.Beg_ODM(idx) == new_seg(j).Beg_ODM);
            if isempty(io)
                io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.Beg_ODM] == new_seg(j).Beg_ODM,1,'first');
                if isempty(io)
                    io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.End_ODM] == new_seg(j).Beg_ODM,1,'first');
                    if isempty(io)
                        io = idx(nm.End_ODM(idx) == new_seg(j).Beg_ODM);
                        pm = nm.End_PM{io};
                        new_seg(j).Beg_Bdry_Type = 'Project'; %#ok<AGROW>
                    else
                        pm = xls(io).End_PM;
                        new_seg(j).Beg_Bdry_Type = nm.End_Bdry_Type{io}; %#ok<AGROW>
                    end
                else
                    pm = xls(io).Beg_PM;
                    new_seg(j).Beg_Bdry_Type = 'Project'; %#ok<AGROW>
                end
            else
                pm = nm.Beg_PM{io};
                new_seg(j).Beg_Bdry_Type = nm.Beg_Bdry_Type{io}; %#ok<AGROW>
            end
            pm = regexp(pm,'^([A-Z]?)([0-9]+.[0-9]*)([LR]?)$','tokens');
            new_seg(j).BPP = pm{1}{1}; %#ok<AGROW>
            new_seg(j).Beg_PM = pm{1}{2}; %#ok<AGROW>
            new_seg(j).BPS = pm{1}{3}; %#ok<AGROW>
            io = idx(nm.End_ODM(idx) == new_seg(j).End_ODM);
            if isempty(io)
                io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.End_ODM] == new_seg(j).End_ODM,1,'first');
                if isempty(io)
                    io = find(strcmp(rte{ir},{xls.Route}) & strcmp(dirs{id},{xls.Dir}) & [xls.Beg_ODM] == new_seg(j).End_ODM,1,'first');
                    if isempty(io)
                        io = idx(nm.Beg_ODM(idx) == new_seg(j).End_ODM);
                        pm = nm.Beg_PM{io};
                        new_seg(j).End_Bdry_Type = 'Project'; %#ok<AGROW>
                    else
                        pm = xls(io).Beg_PM;
                        new_seg(j).End_Bdry_Type = nm.Beg_Bdry_Type{io}; %#ok<AGROW>
                    end
                else
                    pm = xls(io).End_PM;
                    new_seg(j).End_Bdry_Type = 'Project'; %#ok<AGROW>
                end
            else
                pm = nm.End_PM{io};
                new_seg(j).End_Bdry_Type = nm.End_Bdry_Type{io}; %#ok<AGROW>
            end
            pm = regexp(pm,'^([A-Z]?)([0-9]+.[0-9]*)([LR]?)$','tokens');
            new_seg(j).EPP = pm{1}{1}; %#ok<AGROW>
            new_seg(j).End_PM = pm{1}{2}; %#ok<AGROW>
            new_seg(j).EPS = pm{1}{3}; %#ok<AGROW>
        end
        clear route pm io j;
        if ~isempty(new_loc)
            final_loc = [final_loc; new_loc]; %#ok<AGROW>
        end
        final_seg = [final_seg; new_seg]; %#ok<AGROW>
        clear idx odm split new_loc new_seg;
    end
end

final_loc = rmfield(final_loc,'line');
%disp(struct2cell(final_loc)')
xlswrite(fname,[fieldnames(final_loc)'; struct2cell(final_loc)'],2);
final_seg = rmfield(final_seg,{'line','Year','Plan_Year','Treatment','Estimated_Cost','MWP_Project_Status'});
xlswrite(fname,[fieldnames(final_seg)'; struct2cell(final_seg)'],3);
if exist(ps_group{1},'file')
    ps2pdf('psfile',ps_group{1},'pdffile',strrep(ps_group{1},'.ps','.pdf'),'deletepsfile',1);
end
if exist(ps_group{2},'file')
    ps2pdf('psfile',ps_group{2},'pdffile',strrep(ps_group{2},'.ps','.pdf'),'deletepsfile',1);
end

return

function x = cleanstr(x)
    if isempty(x)
        x = '';
    elseif isnan(x(1))
        x = '';
    end
return

function [loc,seg] = group(rtedir,loc,odm,msk,tlm)
    global treatments ps_group;
    tl = {'network master' 'before grouping' 'after grouping' 'final treatments'};
    swap = @(varargin) varargin{nargin:-1:1};
    
    % Plotting
    disp([rtedir ' Setup:']);
    [ah,phl] = create_plot(tl,odm,strfind(rtedir,'Right'));
    plot_mask(msk,odm,phl(:,:,1),false);
    % store the original msk and treatments
    om1 = msk;
    ol1 = loc;
    % pre-process the pavement types to exclude short isolated sections
    % of different pavement.
    split = refine_split([],odm,[],[],[]);
    map = reshape(1:(size(msk,1)*size(msk,2)),size(msk)).*(msk ~= 0);
    msk = pre_group(msk,map,odm,split,tlm);
    plot_mask(msk,odm,phl(:,:,2),false);
    % redo to further remove small segments
    split = refine_split(split,odm,msk,[],[]);
    msk = pre_group(msk,map,odm,split,tlm);
    split = refine_split([],odm,[],[],[]); % put back original
    % Now remove any project for flipped segments
    [io,il] = find(msk ~= om1);
    for i = 1:length(io)
        mask = arrayfun(@(x) (il(i) == x.Lane || x.Lane == 0) && ...
            x.Beg_ODM < odm(io(i),2) && ...
            x.End_ODM > odm(io(i),1) && ...
            strcmp('Scenario Recommended',x.MWP_Project_Status),loc);
        loc(mask) = [];
    end
    clear i j io il mask;

    % store the new mask for latter plotting
    om2 = msk;
    plot_mask(msk,odm,phl(:,:,3),true);

    % work out where the odm boundaries we should not cross are...
    split = refine_split(split,odm,msk,loc(~strcmp('Scenario Recommended',{loc.MWP_Project_Status})),[]);
    % we now start the real grouping!  We proceed year by year
    years = unique([loc.Plan_Year]);
    iy = 1;
    while iy <= length(years)
        if ~any([loc.Plan_Year] == years(iy))
            years(iy) = [];
            continue;
        end
        % plotting
        disp([rtedir ' Plan Year ' num2str(years(iy)) ':']);
        for i = 1:length(tl);
            title(ah(i),[rtedir ' Plan Year ' num2str(years(iy)) ' ' tl{i}]);
        end
        clear i;
        set(phl(phl > 0),'FaceColor',[1 1 1]);
        plot_mask(msk,odm,phl(:,:,1),true);

        % build a map of the treatment locations and original xls line
        % numbers.  Here we limit to scenario recommended and current year
        % for the map.  We don't complain about dups in time (we expect them).
        [map,lln] = map_treatments(years(iy):years(end),odm,loc,msk,phl(:,:,2),years(iy),[]);
        ohl = plot_outline(map,phl(:,:,2),ah(2));
        % This time we loop over all the segments looking for matches to
        % grow the segments.
        for il = 1:size(map,2)
            % First extract all the index values from the map, keeping odm order
            idx = find(diff(map(:,il)));
            idx = [[1; idx+1] [idx; size(map,1)]];
            idx(:,3:4) = 0; % set our merge probabilities and recalc flag to zero.
            while true
                for ii = 2:size(idx,1)
                    if idx(ii,4)
                        continue;
                    end
                    idx(ii,4) = 1;
                    io = idx(ii,1);
                    jo = idx(ii-1,2);
                    if any(split(:,1) == io | split(:,2) == jo)
                        continue;
                    end
                    [s,so] = get_max_coverage(io,il,split,msk);
                    i = map(io,il);
                    j = map(jo,il);
                    if lln(io,il) == lln(jo,il) && lln(io,il) ~= 0
                        idx(ii,3) = 1.0; % merge originally merged projects.
                    elseif i > 0 && j > 0
                        [ti,~,~,li,~,yi] = get_treatment(i,map,tlm,lln);
                        [tj,~,~,lj,~,yj] = get_treatment(j,map,tlm,lln);
                        % never different pavement types or only future year projects
                        % or if either project has reduced to a 'do nothing'.
                        if ti == 0 || tj == 0 || treatments{ti,2} ~= treatments{tj,2} || msk(io,il) ~= msk(jo,il) ...
                        || (loc(i).Plan_Year ~= years(iy) && loc(j).Plan_Year ~= years(iy))
                            idx(ii,3) = 0;
                        else
                            to = abs(treatments{ti,3} - treatments{tj,3}) / 5;
                            lo = (li+lj) / 25.0;
                            yo = abs(max(yi,years(iy)) - max(yj,years(iy))) / 2;
                            idx(ii,3) = exp(log(0.5)*sqrt(to^2+lo^2+yo^2));
                            %idx(ii,3) = 1-stdnormal_cdf(log(sqrt(to^2+lo^2+yo^2)));
                            clear to lo yo;
                        end
                        clear ti tj li lj yi yj;
                    elseif i > 0
                        ti = get_treatment(i,map,tlm,lln);
                        if ti == 0 || msk(io,il) ~= msk(jo,il) || (loc(i).Plan_Year ~= years(iy))
                            idx(ii,3) = 0;
                        else
                            if split(s,3)
                                pp = 0.5; % always extend in lane based zones...
                            else
                                sd = (odm(io,1)-odm(so(1),1)) / 1.0;
                                pp = exp(log(0.5)*sd);
                            end
                            idx(ii,3) = pp;
                            for j = find(([loc.Beg_ODM] < odm(jo,2)) ...
                                   & ([loc.End_ODM] > odm(split(s,1),1)) ...
                                   & ([loc.Plan_Year] >= years(iy)) ...
                                   & strcmp('Scenario Recommended',{loc.MWP_Project_Status}))
                                if treatments{ti,2} ~= treatments{loc(j).Treatment,2}
                                    continue;
                                end
                                to = abs(treatments{ti,3} - treatments{loc(j).Treatment,3}) / 5;
                                lo = (sum(tlm(map == i))+tlm(jo,il)) / 25.0;
                                if loc(j).Lane == 0
                                    xo = 0;
                                else
                                    xo = abs(il - loc(j).Lane) / 6;
                                end
                                yo = abs(loc(i).Plan_Year - loc(j).Plan_Year) / 2;
                                do = abs(min(loc(j).End_ODM,odm(jo,2))-odm(io,1)) / 2.0;
                                idx(ii,3) = max(idx(ii,3),pp+(1-pp)*exp(log(0.5)*sqrt(to^2+lo^2+yo^2+do^2+xo^2)));
                                clear to lo yo do xo;
                            end
                            clear j;
                        end
                    else
                        tj = get_treatment(j,map,tlm,lln);
                        if tj == 0 || msk(io,il) ~= msk(jo,il) || (loc(j).Plan_Year ~= years(iy))
                            idx(ii,3) = 0;
                        else
                            if split(s,3)
                                pp = 0.5; % always extend in lane based zones...
                            else
                                sd = (odm(so(2),2)-odm(jo,2)) / 1.0;
                                pp = exp(log(0.5)*sd);
                            end
                            idx(ii,3) = pp;
                            for i = find(([loc.End_ODM] > odm(io,1)) ...
                                   & ([loc.Beg_ODM] < odm(split(s,2),2)) ...
                                   & ([loc.Plan_Year] >= years(iy)) ...
                                   & strcmp('Scenario Recommended',{loc.MWP_Project_Status}))
                                if treatments{tj,2} ~= treatments{loc(i).Treatment,2}
                                    continue;
                                end
                                to = abs(treatments{tj,3} - treatments{loc(i).Treatment,3}) / 5;
                                lo = (sum(tlm(map == j))+tlm(io,il)) / 25.0;
                                if loc(j).Lane == 0
                                    xo = 0;
                                else
                                    xo = abs(il - loc(j).Lane) / 6;
                                end
                                yo = abs(loc(j).Plan_Year - loc(i).Plan_Year) / 2;
                                do = abs(max(loc(i).Beg_ODM,odm(io,1))-odm(jo,2)) / 2.0;
                                idx(ii,3) = max(idx(ii,3),pp+(1-pp)*exp(log(0.5)*sqrt(to^2+lo^2+yo^2+do^2+xo^2)));
                                clear to lo yo do xo;
                            end
                            clear j;
                        end
                    end
                end
                clear i j io jo do go;
                if isempty(idx) || max(idx(:,3)) < 0.5
                    % we found nothing to merge
                    break;
                end
                [~,ii] = max(idx(:,3));
                %disp([odm(idx(:,1),1) odm(idx(:,2),2) idx(:,3) idx(:,4)]);
                %disp([ii idx(ii,3)]);
                io = idx(ii,1);
                jo = idx(ii-1,2);
                i = map(io,il);
                j = map(jo,il);
                if i > 0 && j > 0
                    if loc(j).Plan_Year < loc(i).Plan_Year
                        [i,j] = swap(i,j);
                    end
                    map(map == j) = i;
                    idx(ii-1,2) = idx(ii,2);
                    idx(ii,:) = [];
                    idx(ii-1:min(size(idx,1),ii),3:4) = 0;
                elseif i > 0
                    if lln(jo,il) == 0
                        lln(jo,il) = lln(io,il);
                    end
                    map(jo,il) = i;
                    idx(ii,1) = idx(ii,1)-1;
                    idx(ii-1,2) = idx(ii-1,2)-1;
                    idx(max(1,ii-2):ii,3:4) = 0;
                    if idx(ii-1,2) < idx(ii-1,1)
                        idx(ii-1,:) = [];
                    end
                else
                    if lln(io,il) == 0
                        lln(io,il) = lln(jo,il);
                    end
                    map(io,il) = j;
                    idx(ii-1,2) = idx(ii-1,2)+1;
                    idx(ii,1) = idx(ii,1)+1;
                    idx(ii-1:min(size(idx,1),ii+1),3:4) = 0;
                    if idx(ii,2) < idx(ii,1)
                        idx(ii,:) = [];
                    end
                end
                clear ii j jo i io;
            end
            clear idx;
        end
        clear il;
        % replot the original treatments with the new lane segments
        map_treatments(years(iy):years(end),odm,loc,msk,phl(:,:,3),0,[]);
        ohl2 = plot_outline(map,phl(:,:,3),ah(3));
        % Now we look for adjacent lanes and merge them.
        % Loop over segments in descending length order
        [~,map] = pre_group(abs(msk),map,odm,refine_split(split,odm,msk,[],map),[]);
        % Now that we've reduced to the minimum projects, figure out what
        % is too small to worry about and update those going through.
        idx_y = unique(map(map > 0));
        del = []; def = [];
        % Now set the correct treatment.
        for i = idx_y(:)'
            [j,t,tot,len,lines,y] = get_treatment(i,map,tlm,lln);
            %b = xls(find(strcmp(t,{xls.Treatment}),1,'first')).Budget_Group;
            [io,il] = find(map == i);
            io = unique(io);
            il = unique(il);
            [s,so] = get_max_coverage(io,il,split,msk);
            if strcmp('Scenario Recommended',loc(i).MWP_Project_Status) ... 
            && (j == 0 || y > years(iy)+3 || ((len < 2.0 || tot < treatments{j,7}) && ~(so(1) == io(1) && so(2) == io(end))) ...
              || (split(s,3) && ~(so(1) == io(1) && so(2) == io(end))))
                % Defer the projects we are skipping...
                idx_y(idx_y == i) = [];
                def = [def(:); find(arrayfun(@(x) any(x.line == lines) && x.Plan_Year <= years(iy),loc))];
                clear lines len tot t_len t_tot j t_diff t;
                continue;
            end
            loc(i).Beg_ODM = odm(min(io),1);
            loc(i).End_ODM = odm(max(io),2);
            if ~any(any(arrayfun(@(x,y) x ~= i && y ~= 0,map(io,:),msk(io,:))))
                loc(i).Lane = 0;
            end
            loc(i).Treatment = t;
            loc(i).Estimated_Cost = tot;
            loc(i).Total_Lane_Miles = len;
            % Delete the other locations...
            if j == 0
                j = find(strcmp(regexprep(t,' - .*',''),treatments(:,1)));
                del = [del(:); find(arrayfun(@(x) x.line == loc(i).line && ...
                    (loc(i).Lane == x.Lane || loc(i).Lane == 0 || x.Lane == 0) && ...
                    x.Beg_ODM < loc(i).End_ODM && ...
                    x.End_ODM > loc(i).Beg_ODM,loc(:)))];
                del(del == i) = [];
            else
                % use the xls line numbers here, to find all the lost projects.
                del = [del(:); find(arrayfun(@(x) any(x.line == lines) && x.line ~= loc(i).line,loc))];
            end
            msk(map == i) = -treatments{j,5};
            clear len tot j t io;

            % plotting
            h = phl(:,:,4);
            t = strcmp(regexprep(loc(i).Treatment,' - .*',''),treatments(:,1));
            ph = h(map == i);
            ph(ph == 0) = []; % XXX
            set(ph,'FaceColor',treatments{t,4});
            clear ph h t;
        end
        % recalc where the odm boundaries we should not cross are...
        split = refine_split(split,odm,msk,loc(idx_y),[]);
        ohl3 = plot_outline(map,phl(:,:,4),ah(4));
        % Now look for overlapping projects in future years and delete them
        y = years(iy+1:end);
        for i = idx_y(:)'
            del = [del(:); find(arrayfun(@(x) any(x.Plan_Year == y) && ...
                strcmp('Scenario Recommended',x.MWP_Project_Status) && ...
                strcmp('Scenario Recommended',loc(i).MWP_Project_Status) && ...
                (loc(i).Lane == x.Lane || loc(i).Lane == 0 || x.Lane == 0) && ...
                x.Beg_ODM < loc(i).End_ODM && ...
                x.End_ODM > loc(i).Beg_ODM && ...
                ~any(i == del),loc))];
        end
        % Delete all these projects, since we're done with index
        % values.  First unset the plan year
        for i = del(:)'
            loc(i).Plan_Year = NaN;
        end
        % now delete plan years with no projects
        iy = iy+1;
        while iy <= length(years) && ~any([loc.Plan_Year] == years(iy))
            years(iy) = [];
        end
        % now defer projects into the next plan year
        if iy > length(years)
            del = [del; def]; %#ok<AGROW>
        else
            for i = def(:)'
                % delete defered projects with future work
                mask = arrayfun(@(x) x.Plan_Year == years(iy) && ...
                    (loc(i).Lane == x.Lane || loc(i).Lane == 0 || x.Lane == 0) && ...
                    x.Beg_ODM < loc(i).End_ODM && ...
                    x.End_ODM > loc(i).Beg_ODM,loc);
                if any(mask)
                    for j = find(mask)
                        if treatments{loc(j).Treatment,2} ~= treatments{loc(i).Treatment,2} ...
                        || treatments{loc(j).Treatment,3} > treatments{loc(i).Treatment,3}
                            del(end+1) = j; %#ok<AGROW>
                            loc(i).Plan_Year = years(iy);
                        else
                            del(end+1) = i; %#ok<AGROW>
                        end
                    end
                else
                    loc(i).Plan_Year = years(iy);
                end
            end
        end
        % now clean the deleted projects out.
        loc(del) = [];
        clear y i idx_y del def;

        % Plotting
        print(gcf,'-dpsc2',ps_group{1},'-append');
        delete(ohl);
        delete(ohl2);
        delete(ohl3);
        clear ohl ohl2 ohl3;
    end
    % sometimes, if the network master and the scenario have different
    % segmentations, some scenario projects make it through.
    loc(arrayfun(@(x) isnumeric(x.Treatment),loc)) = [];
    
    % Plotting
    close gcf;
    clear ah phl;
    disp([rtedir ' Final:']);
    tl{5} = tl{4};
    tl{4} = 'original treatments';
    [ah,phl] = create_plot(tl,odm,strfind(rtedir,'Right'));
    for i = 1:length(tl);
        title(ah(i),[rtedir ' Segments ' tl{i}]);
    end
    plot_mask(om1,odm,phl(:,:,1),false);
    plot_mask(om2,odm,phl(:,:,2),false);
    plot_mask(msk,odm,phl(:,:,3),true);
    % replot the original treatment plan...
    years = unique([ol1.Plan_Year]);
    if isempty(years)
        years = 1;
    end
    map_treatments(years,odm,ol1,[],phl(:,:,4),0,[]);

    % copy the grouped treatments to make the segment list.
    seg = loc;
    del = [];
    for i = 1:length(seg)
        % go back to treatment index.
        seg(i).MWP_Project_Status = 'Scenario Recommended';
        seg(i).Treatment = find(strcmp(regexprep(seg(i).Treatment,' - .*',''),treatments(:,1)));
        seg(i).line = 1e6+i;
        % if this is a programmed project remove all future projects
        idx = find(arrayfun(@(x) (seg(i).Lane == x.Lane || seg(i).Lane == 0 || x.Lane == 0) && ...
            x.Beg_ODM < seg(i).End_ODM && ...
            x.End_ODM > seg(i).Beg_ODM && ...
            x.Plan_Year > seg(i).Plan_Year,seg));
        del = [del; idx]; %#ok<AGROW>
    end
    seg(del) = [];
    % recalc where the odm boundaries we should not cross are...
    split = refine_split([],odm,msk,seg,[]);
    % now add do-nothing segments for the un-treated locations
    % first flip back to negatives as missing
    msk = -msk;
    [io,il] = find(msk < 0);
    for i = 1:length(io)
        seg(end+1).Treatment = 0; %#ok<AGROW>
        seg(end).Beg_ODM = odm(io(i),1);
        seg(end).End_ODM = odm(io(i),2);
        seg(end).Lane = il(i);
        seg(end).MWP_Project_Status = 'Scenario Recommended';
        seg(end).Plan_Year = years(1);
        seg(end).line = max([seg.line])+1;
        if isempty(seg(end).line)
            seg.line = 1e6+1;
        end
    end
    % get the final coverage.  We use all years and complain if there are
    % overlaps.  No test of surface type is done.
    [map,~] = map_treatments(years,odm,seg,[],phl(:,:,5),0,'Ooops - overlap in generated segments!');
    % now treat the segment id like a pavement type and remove all unknowns
    if any(any(msk < 0))
        % now overwrite msk with the map values.
        [~,new] = pre_group(abs(msk),map,odm,split,[]);
        map(msk < 0) = new(msk < 0);
    end
    del = [];
    for i = 1:length(seg)
        [io,il] = find(map == i);
        if isempty(io) || isempty(il)
            del(end+1) = i; %#ok<AGROW>
            continue;
        end
        io = unique(io);
        il = unique(il);
        seg(i).Beg_ODM = odm(min(io),1);
        seg(i).End_ODM = odm(max(io),2);
        seg(i).Total_Lane_Miles = sum(tlm(map == i));
        % set the do nothing treatment to all lanes if needed.
        if all(all(map(io,:) == i | map(io,:) == 0)) && seg(i).Treatment == 0
            seg(i).Lane = 0;
        end
        if (seg(i).Lane == 0)
            assert(all(all(map(io,:) == i | map(io,:) == 0)),'Ooops');
        else
            assert(all(seg(i).Lane == il),'Ooops');
        end
    end
    % now remap and plot
    seg(del) = [];
    [map,~] = map_treatments(years,odm,seg,[],phl(:,:,5),0,'Ooops - overlap in final generated segments!');
    seg = seg(:);

    % Plotting
    plot_outline(map,phl(:,:,5),ah(5));
    print(gcf,'-dpsc2',ps_group{2},'-append');
    close gcf;
return

% get a suitable treatment type for a location i in the map.
function [j,t,tot,len,lines,y] = get_treatment(i,map,tlm,lln)
    global treatments xls;

    % get total lane miles
    len = sum(tlm(arrayfun(@(x) any(x == i),map)));
    % get the work plan lines
    lines = unique(lln(arrayfun(@(x) any(x == i),map)));
    lines(lines == 0) = [];
    % get allocated cost
    tot = sum([xls(lines).Estimated_Cost]);
    % get the used treatments
    t = unique({xls(lines).Treatment});
    t_len = zeros(size(t));
    t_tot = zeros(size(t));
    for j = 1:length(t)
        % get the matching lines for each treatment
        l = lines(strcmp(t{j},{xls(lines).Treatment}));
        t_len(j) = sum([xls(l).Total_Lane_Miles]);
        t_tot(j) = sum([xls(l).Estimated_Cost]);
    end
    % add 'do nothing' to the end for the rest of the miles
    t_len(end+1) = len-sum(t_len); 
    t_tot(end+1) = 0;
    % get the unit cost for each treatment and diff.
    t_diff = t_tot./t_len-tot/len;
    % Make lower cost projects two times less desireable
    t_diff(t_diff < 0) = 2*t_diff(t_diff < 0);
    % Get the nearest treatment type.
    [~,j] = min(abs(t_diff));
    % look it up again.
    if ~strcmp('Scenario Recommended',unique({xls(lines).MWP_Project_Status}))
        t = unique({xls(lines).Treatment});
        j = 0;
        y = unique([xls(lines).Plan_Year]);
    elseif j > length(t)
        t = '';
        j = 0;
        y = 0;
    else
        t = t{j};
        j = find(strcmp(regexprep(t,' - .*',''),treatments(:,1)));
        y = sum([xls(lines).Plan_Year].*[xls(lines).Estimated_Cost])/tot;
    end
return

% This function creates a map of treatments from the loc array, and an
% associated array of back references to line numbers.  Depending on t_year
% only one year of data is included in the map (but lines are always done).
function [map,lln] = map_treatments(years,odm,loc,msk,phl,t_year,lln_disp)
    global treatments;
    if isempty(years) || isempty(loc)
        return;
    end
    map = zeros(size(odm,1),max(odm(:,3)));
    lln = zeros(size(odm,1),max(odm(:,3)));
    for io = 1:size(odm,1)
        for y = years(1):years(end)
            % get all overlapping projects in this year...
            idx = find(([loc.Plan_Year] == y) & ([loc.Beg_ODM] < odm(io,2)) & ([loc.End_ODM] > odm(io,1)));
            % continue if none...
            if isempty(idx)
                continue;
            end
            % Get the lanes and check for missing lanes
            for il = 1:odm(io,3)
                i = idx([loc(idx).Lane]==il | [loc(idx).Lane]==0);
                if isempty(i)
                    % no overlap in lanes
                    continue;
                elseif ~isscalar(i)
                    disp('Ooops - Overlapping treatments!')
                    continue;
                elseif lln(io,il) > 0
                    % we already have a treatment here... Complain if
                    % needed...
                    disp(lln_disp);
                    continue;
                elseif isnumeric(loc(i).Treatment) && ~isempty(msk) && treatments{loc(i).Treatment,2} ~= abs(msk(io,il));
                    % wrong type of project for this pavement...
                    disp('Oops - wrong treatment type!');
                    continue;
                end
                % build the map
                if y == t_year || t_year == 0
                    map(io,il) = i;
                end
                % store the backref to the xls line
                lln(io,il) = loc(i).line;

                % Plotting: set the color
                a = max(0.2,exp(log(0.5)*(y-years(1))/4));
                if ~isnumeric(loc(i).Treatment)
                    c = treatments{strcmp(regexprep(loc(i).Treatment,' - .*',''),treatments(:,1)),4};
                elseif loc(i).Treatment > 0
                    c = treatments{loc(i).Treatment,4};
                else
                    c = [1 1 1];
                end
                c = [1 1 1]*(1-a)+c*a;
                set(phl(io,il),'FaceColor',c);
            end
        end
    end
return

% pre-process the mask to exclude short isolated sections of different
% pavement, and remove unknowns.  The map provides the initial
% segmentation.
function [msk,map] = pre_group(msk,map,odm,split,tlm)
    old = map; changed_split = false;
    % first make them as long as possible in longitudinally, since
    % this really speeds things up.  Don't merge unknowns (negatives).
    for il = 1:size(map,2)
        for io = 2:size(map,1)
            if msk(io-1,il) == msk(io,il) && msk(io,il) > 0 && ~any(split(:,1) == io)
                map(io,il) = map(io-1,il);
            end
        end
    end
    % now do the slow way.
    ii = 0;
    while true
        % get rid of unknown pavement types
        while any(any(msk < 0))
            % undo any merging of unknown sections and restart...
            map(msk < 0) = old(msk < 0);
            % work with the index values since the undo above might not
            % have solved all the problems...
            idx = unique(map(msk < 0));
            for ii = idx(:)'
                assert(ii > 0,'Ooops - msk covers more than map!'); 
                % we always mask for only unknowns, so that we skip
                % ones we've already taken care of.  First loop
                % longitudinally.
                [io,~] = find(map == ii & msk < 0);
                for i = unique(io)'
                    % now get the lanes
                    [~,il] = find(map(i,:) == ii & msk(i,:) < 0);
                    [s,so] = get_max_coverage(io,il,split,msk);
                    %t = unique(abs(msk(so,:)));
                    %split(s,3) = ~isscalar(t(t>0));
                    % if one lane or all segments are unknown, look left/right
                    % also if we have more than one unknown and up/down
                    % might be risky
                    if length(il) > 1 || any(split(s,3)) || odm(i,3) == 1 || all(msk(i,1:odm(i,3)) < 0)
                        % first look later
                        if i < so(2)
                            for j = find(map(i,:) > 0 & map(i+1,:) > 0 & msk(i,:) < 0)
                                msk(map == map(i,j)) = msk(i+1,j);
                            end
                        end
                        % now look earlier
                        if i > so(1)
                            for j = find(map(i,:) > 0 & map(i-1,:) > 0 & msk(i,:) < 0)
                                msk(map == map(i,j)) = msk(i-1,j);
                            end
                        end
                        % if we still have unknowns get the first unknown lane.
                        [~,il] = find(msk(i,:) < 0,1,'first');
                    end
                    % now look by lane, if we have only more than one lane,
                    % and not all lanes are unknown.
                    if length(il) == 1 && ~any(split(s,3)) && odm(i,3) > 1 && msk(i,il) < 0 && ~all(msk(i,1:odm(i,3)) < 0)
                        % look up/down
                        if il == 1
                            while il <= odm(i,3) && msk(i,il) < 0
                                il = il+1;
                            end
                            if il <= odm(i,3)
                                msk(map == ii) = msk(i,il);
                            end
                        else
                            while il >= 1 && msk(i,il) < 0
                                il = il-1;
                            end
                            if il >= 1
                                msk(map == ii) = msk(i,il);
                            end
                        end
                    end
                end
            end
            % check what remains...
            idx = unique(map(msk < 0));
            for ii = idx(:)'
                [io,il] = find(map == ii);
                [s,so] = get_max_coverage(unique(io),unique(il),split,msk);
                % if we are in a mixed segment and as long as possible,
                % just flip the type.  This is only triggered for the post
                % call.
                if any(split(s,3)) && all(all(msk(so(1):so(2),il) < 0))
                    msk(map == ii) = abs(msk(map == ii));
                end
                % if every segment in the split is unknown, just flip it...
                if all(all(msk(split(s(1),1):split(s(end),2),:) <= 0))
                    msk(map == ii) = abs(msk(map == ii));
                end
            end
            ii = 0;
        end
        if ii == 0
            idx_y = unique(map(map > 0));
            if ~isempty(tlm)
                ord = zeros(length(idx_y),4);
                for i = 1:length(idx_y)
                    [io,il] = find(map == idx_y(i));
                    t = unique(msk(map == idx_y(i)));
                    msk2 = msk(io,:);
                    tlm2 = tlm(io,:);
                    ord(i,1) = sum(tlm(map == idx_y(i)));
                    % get the ratio of this type of pavement to all that
                    % in this segment.
                    ord(i,2) = sum(tlm2(msk2 == t))/sum(tlm2(:));
                    ord(i,3) = -min(il);
                    ord(i,4) = -idx_y(i);
                end
                [~,ord] = sortrows(ord);
                idx_y = idx_y(ord);
                clear ord msk2 tlm2 i t io;
            else
                ord = zeros(size(idx_y));
                for i = 1:length(idx_y)
                    [io,~] = find(map == idx_y(i));
                    ord(i) = odm(max(io),2)-odm(min(io),1);
                end
                [~,ord] = sort(ord,'descend');
                idx_y = idx_y(ord);
                clear ord i io;
            end
            ii = 1;
        end
        if changed_split
            split = refine_split(split,odm,msk,[],[]);
            changed_split = false;
        end
        % get our index and type
        if isempty(idx_y)
            break;
        end
        idx = idx_y(ii);
        t = unique(msk(map == idx));
        assert(isscalar(t),'Ooops - segment spans more than one pavement type!');
        %disp([ii idx t]);
        % now loop trying to expand as large as possible
        while true
            % first get all the rows and colums
            [io,il] = find(arrayfun(@(x) any(x == idx) && x ~= 0,map));
            % now reduce to the bounding rect
            io = unique(io);
            il = unique(il);
            [s,so] = get_max_coverage(io,il,split,msk);
            % try to extend longitudinally
            if io(1) > so(1)
                % first check if the section before has something, and if
                % it is either all the same type as us, or zero.
                if any(map(io(1)-1,:) ~= 0) && all(all(msk(io(1)-1:io(1),:) == t | msk(io(1)-1:io(1),:) == 0)) && ~any(split(s,3))
                    % in this case add all the index values
                    idx = [idx(:)' map(io(1)-1,:)];
                    continue;
                % else we check of we have one lane and the section before
                % is there and has the same type as us.
                elseif (length(il) == 1 || odm(io(1),3) == 1) && map(io(1)-1,il(1)) ~= 0 && msk(io(1)-1,il(1)) == t
                    idx(end+1) = map(io(1)-1,il(1)); %#ok<AGROW>
                    continue;
                end
            end
            % now look the other way...
            if io(end) < so(2)
                if any(map(io(end)+1,:) ~= 0) && all(all(msk(io(end):io(end)+1,:) == t | msk(io(end):io(end)+1,:) == 0)) && ~any(split(s,3))
                    idx = [idx(:)' map(io(end)+1,:)];
                    continue;
                elseif (length(il) == 1 || odm(io(end),3) == 1) && map(io(end)+1,il(1)) ~= 0 && msk(io(end)+1,il(1)) == t
                    idx(end+1) = map(io(end)+1,il(1)); %#ok<AGROW>
                    continue;
                end
            end
            % simplify and remove the zero index values
            idx = unique(idx(idx ~= 0));
            % now check of there are any other sections in this odometer
            % range with the same type and that are not already in the
            % index list.
            if ~isempty(tlm) || ~any(split(s,3))
                il = 1:size(msk,2);
            end
            if ~any(any(arrayfun(@(x,y) x ~= 0 && y == t && ~any(x == idx),map(min(io):max(io),min(il):max(il)),msk(min(io):max(io),min(il):max(il)))))
                break;
            end
            % collect all the sections, then remove zeros and ones with the
            % wrong type.
            idx = unique(map(min(io):max(io),min(il):max(il)));
            idx(idx == 0) = [];
            for j = idx(:)'
                if unique(msk(map == j)) ~= t
                    idx(idx == j) = [];
                end
            end
        end
        % now that we have the list, remove the seed segment.
        i = idx_y(ii);
        idx(idx == i) = [];
        [io,il] = find(map == i);
        % now do the hard work of checking continuity with the seed
        % segment.
        for j = idx(:)'
            p = false;
            [jo,jl] = find(map == j);
            for ij = 1:length(io)
                for jj = 1:length(jo)
                    % check if from one cell in the seed we can find a path
                    % with the same surface type to the new segment
                    if all(all(msk(min(io(ij),jo(jj)):max(io(ij),jo(jj)),min(il(ij),jl(jj)):max(il(ij),jl(jj))) == t))
                        p = true;
                        break;
                    end
                end
                if p; break; end;
            end
            % if we didn't find a path, remove this segment.
            if ~p
                idx(idx == j) = [];
            else
                io = [io; jo]; %#ok<AGROW>
                il = [il; jl]; %#ok<AGROW>
            end
        end
        if ~isempty(idx)
            % remove the segments, and find the new loop counter.
            for j = idx(:)'
                map(map == j) = i;
                idx_y(idx_y == j) = [];
            end
            ii = 0; % restart to ensure lateral sort of segments in mixed
            continue; % go again with this segment, just in case...
        elseif ~isempty(tlm)
            % this section is as big as it can get...
            % get the lane miles, length and total possible lane miles.
            l = sum(tlm(map == i));
            o = max(odm(io,2))-min(odm(io,1));
            t = sum(odm(io,2)-odm(io,1));
            if (l < 0.5*max(odm(io,3)) || o < 0.5 || l < t*0.5)
                [s,so] = get_max_coverage(unique(io),unique(il),split,msk);
                % free this segment to merge
                if any(split(s,3))
                    split(s,3) = 0;
                    changed_split = true;
                end
                if s(end) < size(split,1) && ~split(s(end)+1,3) && odm(split(s(end)+1,1),3) > 0
                    split(s(end),2) = split(s(end)+1,2);
                    split(s(end)+1,:) = [];
                    changed_split = true;
                end
                if s(1) > 1 && ~split(s(1)-1,3) && odm(split(s(1)-1,2),3) > 0
                    split(s(1),1) = split(s(1)-1,1);
                    split(s(1)-1,:) = [];
                    changed_split = true;
                end
                if ~changed_split && min(io) == so(1) && max(io) == so(2)
                    % we cannot grow, so just live with a tiny segment...
                    msk(map == i) = abs(msk(map == i));
                else
                    msk(map == i) = -abs(msk(map == i)); % make this unknown...
                    continue; % go again to fix...
                end
            end
        else
            % we only have segment i.  Check if this covers all the
            % segments in the network master.
            [s,~] = get_max_coverage(unique(io),unique(il),split,msk);
            if ~any(any(arrayfun(@(x,y) (x ~= i && x ~= 0 || y ~= t) && y ~= 0,map(io,:),msk(io,:)))) && ~any(split(s,3))
                for j = io(:)'
                    map(j,1:odm(j,3)) = i;
                end
            end
        end
        ii = ii+1;
        if ii > length(idx_y)
            break;
        end
    end
return

function split = refine_split(split,odm,msk,loc,map)
    global xls;
    
    % recalc where the odm boundaries we should not cross are...
    if isempty(split) || isempty(msk)
        split = find(diff(odm(:,3) > 0));
        split = [[1; split+1] [split; size(odm,1)]];
        split(:,3) = 0;
        if isempty(msk)
            return;
        end
    end
    if size(odm,1) == 1
        return;
    end
    mask = zeros(size(odm,1),2);
    for io = 1:size(odm,1)
        mask(io,1) = length(unique(abs(msk(io,1:odm(io,3)))));
    end
    for i = 1:size(split,1)
        mask(split(i,1):split(i,2),2) = split(i,3);
    end
    seg = zeros(size(odm,1)+1,2);
    for io = 2:size(odm,1)
        seg(io) = any(abs(msk(io-1,:)) ~= abs(msk(io,:)) & msk(io-1,:) ~= 0 & msk(io,:) ~= 0);
    end
    if ~isempty(map)
        idx = unique(map(map > 0));
        for i = idx(:)'
            [io,~] = find(map == i);
            seg(min(io),2) = 1;
            seg(max(io)+1,2) = 1;
        end
    else
        for i = 1:length(loc)
            if ~strcmp('Scenario Recommended',loc(i).MWP_Project_Status)
                l = loc(i).line;
                io = find(odm(:,1) >= xls(l).Beg_ODM & odm(:,2) <= xls(l).End_ODM);
                if xls(l).Lane ~= 0
                    mask(io,2) = 1;
                end
            else
                io = find(odm(:,1) >= loc(i).Beg_ODM & odm(:,2) <= loc(i).End_ODM);
                if loc(i).Lane ~= 0
                    mask(io,2) = 1;
                end
            end
            seg(min(io),2) = 1;
            seg(max(io)+1,2) = 1;
        end
    end
    lane = diff(odm(:,3)) ~= 0 & (mask(1:end-1,1) > 1 | mask(1:end-1,2) > 0) & (mask(2:end,1) > 1 | mask(2:end,2) > 0);
    split = find(diff(abs(msk(:,1))) | diff(mask(:,1)) | seg(2:end-1,1) | seg(2:end-1,2) | lane | diff(arrayfun(@(x) find(x >= split(:,1) & x <= split(:,2)),1:size(odm,1))'));
    split = [[1; split+1] [split; size(odm,1)] (mask([1; split+1],1) > 1 | mask([1; split+1],2) > 0)];
return

function [s,so] = get_max_coverage(io,il,split,msk)
    io = [min(io) max(io)];
    s = unique(find(split(:,2) >= io(1) & split(:,1) <= io(2)));
    %assert(isscalar(s),'Ooops - we crossed a hard boundary!');
    so = [split(s(1),1) split(s(end),2)];
    if length(il) == 1
        li = find(msk(so(1):io(1),il) == 0,1,'last');
        if ~isempty(li)
            so(1) = so(1)-1+li+1;
        end
        li = find(msk(io(2):so(2),il) == 0,1,'first');
        if ~isempty(li)
            so(2) = io(2)-1+li-1;
        end
    end
return

function loc = split_project(loc,i,odm,split,tlm)
    io = find(odm(:,1) >= loc(i).Beg_ODM & odm(:,2) <= loc(i).End_ODM);
    if isempty(io)
        return;
    end
    s = unique(find(split(:,2) >= min(io) & split(:,1) <= max(io)));
    if loc(i).Lane == 0
        il = 1:size(tlm,2);
    else
        il = loc(i).Lane;
    end
    t = loc(i).Total_Lane_Miles/sum(sum(tlm(min(io):max(io),il)));
    c = loc(i).Estimated_Cost/sum(sum(tlm(min(io):max(io),il)));
    added = i;
    for j = 2:length(s)
        loc(end+1) = loc(i); %#ok<AGROW>
        added(end+1) = length(loc); %#ok<AGROW>
        loc(i).End_ODM = odm(split(s(j-1),2),2);
        loc(end).Beg_ODM = odm(split(s(j),1),1);
        i = length(loc);
    end
    for j = added(:)'
        jo = find(odm(:,1) >= loc(j).Beg_ODM & odm(:,2) <= loc(j).End_ODM);
        s = unique(find(split(:,2) >= min(jo) & split(:,1) <= max(jo)));
        if split(s,3) && loc(j).Lane == 0
            assert(length(jo) == 1,'Ooops - split by lane means all odometers!');
            for l = 2:odm(jo,3)
                loc(end+1) = loc(j); %#ok<AGROW>
                added(end+1) = length(loc); %#ok<AGROW>
                loc(end).Lane = l;
            end
            loc(j).Lane = 1;
        end
    end
    for j = added(:)'
        jo = find(odm(:,1) >= loc(j).Beg_ODM & odm(:,2) <= loc(j).End_ODM);
        if loc(j).Lane == 0
            il = 1:size(tlm,2);
        else
            il = loc(j).Lane;
        end
        loc(j).Total_Lane_Miles = t*sum(sum(tlm(min(jo):max(jo),il)));
        loc(j).Estimated_Cost = c*sum(sum(tlm(min(jo):max(jo),il)));
    end
return

function ohl = plot_outline(map,phl,ah)
    ohl = [];
    idx = unique(map(map>0));
    for i = idx(:)'
        p = phl(map == i);
        p(p == 0) = []; % XXX
        o = [];
        for j = 1:length(p)
            o = [o; get(p(j),'Vertices')]; %#ok<AGROW>
        end
        %[~,j] = alphavol(o(:,1:2),1.0);
        %j = j.bnd(:,1);
        j = convhull(o(:,1),o(:,2));
        ohl(end+1) = patch(o(j,1),o(j,2),'w','FaceColor','none','LineWidth',2,'Clipping','off','Parent',ah); %#ok<AGROW>
    end
return

function plot_mask(msk,odm,phl,negs)
    for io = 1:size(odm,1)
        for il = 1:odm(io,3)
            if msk(io,il) == 0
                set(phl(io,il),'FaceColor',[1 1 0]);
            elseif msk(io,il) == -1 && negs
                set(phl(io,il),'FaceColor',[0 0 0.5]);
            elseif msk(io,il) == -2 && negs
                set(phl(io,il),'FaceColor',[0 0.5 0]);
            elseif msk(io,il) == 1
                set(phl(io,il),'FaceColor',[0 0 1]);
            elseif msk(io,il) == 2
                set(phl(io,il),'FaceColor',[0 1 0]);
            else
                set(phl(io,il),'FaceColor',[1 0 0]);
            end
        end
    end
return

function [ah,phl] = create_plot(tl,odm,flag)
    figure('Units','inches','Position',[2 1 11 8.5]);
    for i = 1:length(tl);
        ah(i) = subplot(length(tl),1,i); %#ok<AGROW>
        set(ah(i),'Box','on','Layer','bottom',...
            'XGrid','on','YGrid','on','TickDir','out','Clipping','off',...
            'YTick',0:max(odm(:,3)));
        xlabel(ah(i),'State ODM (miles)');
        ylabel(ah(i),'Lanes');
        xlim(ah(i),[odm(1,1) odm(end,2)]);
        ylim(ah(i),[0 max(odm(:,3))]);
        if flag
            set(ah(i),'YDir','reverse');
        end
    end
    phl = zeros(size(odm,1),max(odm(:,3)),3);
    for io = 1:size(odm,1)
        % make patch objects for the lanes
        for il = 1:odm(io,3)
            for i = 1:length(tl)
                phl(io,il,i) = patch([odm(io,1) odm(io,2) odm(io,2) odm(io,1)],[il-1 il-1 il il],'w','LineWidth',0.5,'Parent',ah(i));
            end
        end
    end
    set(gcf,'PaperOrientation','landscape');
    pb = get(gcf,'PaperSize');
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[ 0 0 pb(1)-0 pb(2)-0]);
return

function create_legend()
    global treatments;
    surface = [ treatments(:,[1 4]);
        {'Flexible',[0 0 1];
        'JPC',[0 1 0];
        'Unknown',[1 0 0];
        'Flexible - Done',[0 0 0.5];
        'JPC - Done',[0 0.5 0];
        'Sections (in this year)',[1 1 1];}
    ];
    
    figure('Units','inches','Position',[2 1 11 8.5]);
    hb = bar([1:length(surface); 1:length(surface)]);
    colormap(reshape([surface{:,2}],3,[])');
    hl = legend(gca,surface(:,1));
    set([gca hb],'Visible','off');
    set(hl,'OuterPosition',[0.1 0.1 0.8 0.8]);
    hc = get(hl,'Children');
    set(get(hc(1),'Children'),'LineWidth',2);
    set(gcf,'PaperOrientation','landscape');
    pb = get(gcf,'PaperSize');
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperPosition',[ 0 0 pb(1)-0 pb(2)-0]);
return

function a = num2alpha(x,n)
lookup = [uint8('1'):uint8('9') uint8('A'):uint8('Z') uint8('0')];
a = '';
while x > 0
    y = mod(x,length(lookup));
    if y == 0
        y = length(lookup);
    end
    a = [char(lookup(y)) a]; %#ok<AGROW>
    x = (x-y)/length(lookup);
end
while length(a) < n
    a = ['0' a]; %#ok<AGROW>
end
return
