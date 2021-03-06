% save result to simplified spikes objects
spikes=[];
%  if numel(mua.opt.projectpath)>0
%  spikes.projectpath=mua.opt.projectpath;
%  end;
spikes.sourcefile = features.muafile;
spikes.ts=features.ts;
spikes.cluster_is=features.clusters;
spikes.labelcategories=features.labelcategories;
spikes.clusterlabels=features.clusterlabels;
spikes.sourcechannel=features.sourcechannel;

spikes.Nspikes=mua.Nspikes;

spikes.waveforms=mua.waveforms;
spikes.waveforms_ts=mua.ts_spike;

%outfilename=[spikes.sourcefile(1:end-4),'_clustered.mat'];
outfilename=[features.muafilepath,'ch',num2str(spikes.sourcechannel),'_clustered.mat'];

clear dir;
d=dir(outfilename);
if numel(d)>0
    button = questdlg(['overwrite   ',outfilename,'   ?'],'file exists already','Yes','No','Yes');
else
    button='Yes';
end;

if strcmp(button,'Yes')
    
    
        save_text_h = text(-.5,0,'saving... ', 'BackgroundColor',[.7 .9 .7]);
        drawnow;
        
    
    save(outfilename,'spikes','-v7.3');
    
    % save simpleclust state so we can just load it again
    % if needed
    outfilename_sc=[features.muafilepath,'ch',num2str(spikes.sourcechannel),'_simpleclust.mat'];
    save(outfilename_sc,'features','mua','-v7.3');
    
    disp(['saved to ',outfilename,' output for using in science']);
    disp(['saved to ',outfilename_sc,' can be loaded with simpleclust']);
    delete(save_text_h);
else
    disp('aborted saving open files');
    
end;
