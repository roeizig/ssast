close all; clear all; clc;
files = dir
directoryNames = {files([files.isdir]).name};
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}));

for k = directoryNames
    currD = k{1};
    cd(currD)
    mkdir spectrograms_gray_new
    mkdir spectrograms_new
    mkdir images_new
    wav_dir=dir('*.wav');

    if size(dir('All_echoes.mat'),1)>0
        load All_echoes
    end

    if size(dir('All_times.mat'),1)>0
        load All_times
    end

    if size(dir('x_freq.mat'),1)>0
        load x_freq
    end

    if size(dir('y_freq.mat'),1)>0
        load y_freq
    end

    load('callsTable.mat')
    sr=200000;
    win=1024;
    All_audio=[];

    d_ix=1;
    % for i=1:size(wav_dir,1)/2
    %     wav_dir(i).name
    All_audio=audioread(wav_dir(d_ix).name);
    accum_length=length(All_audio);
    %     All_audio=[All_audio;A];
    % end

    for i=3:(size(callsTable,1)-1)
    %     for i=1:3

        first=callsTable.DetectionTime(i)-0.1;

        if first<0
            first=1;
        end

        last=(callsTable.DetectionTime(i)+0.1)*sr;
        while last>length(All_audio)
            d_ix=d_ix+1;
            A=audioread(wav_dir(d_ix).name);
            All_audio=[All_audio;A];
        end

        tmp=All_audio((callsTable.DetectionTime(i)-0.1)*sr:(callsTable.DetectionTime(i)+0.1)*sr);
        [A,B,C,D]=spectrogram(tmp,win,1000,win,sr,'Yaxis'); %986
        name = strcat('spectrograms_gray_new/',currD,'_','call_',int2str(i),'_label_',num2str(y_freq(i+1)),'.png');
        
        
        prefix = 700;
        suffix = 324;
        start_idx = max(1,round(x_freq(i))-prefix);
        end_idx = min(1625,round(x_freq(i))+suffix);
        temp_A = A(351:478,start_idx:end_idx);
        temp_A = imresize(temp_A,[128 1024], 'nearest');

        imwrite( mat2gray(flipud(log10(abs(temp_A)))), name)
        disp(strcat('saving: ', name));
%         save(name,'temp_A');
        
        fig = figure('Visible','Off');
        imagesc(log10(abs(temp_A)));
        hold on; plot(min(prefix,round(x_freq(i))),round(y_freq(i)),'*r','MarkerSize',30)
        ax = gca;
        ax.YDir = 'normal';
        title(strcat(currD,'-','call-',int2str(i),'-label-',num2str(y_freq(i+1))));
        saveas(fig,strcat('images_new/',currD,'_','call_',int2str(i),'_label_',num2str(y_freq(i+1)),'.png')); 
% %         [x_freq(i),y_freq(i)]=ginput(1);
        
        close all

    %     figure; imagesc(log10(abs(A(301:470,:))))
    %     hold on; %plot(round(size(A,2)/2),50,'*r','MarkerSize',30)
    %     ax = gca;
    %     ax.YDir = 'normal'
    %     title('mark echo')
    % %     mark_area=roipoly;
    % %     close

    %     Only_echo=log10(abs(A(301:470,:))).*double(mark_area);
    %     All_echoes(i,:)=sum(Only_echo); %sum over all rows(freqs) to get
    %     energy at time time unit t
    %     All_times(i,:)=sum(Only_echo');

    %     save All_echoes All_echoes
    %     save All_times All_times
    %     save x_freq x_freq
    %     save y_freq y_freq
    end
    disp('finished')
    cd('..')
end



% accum_length=length(A)+accum_length;
