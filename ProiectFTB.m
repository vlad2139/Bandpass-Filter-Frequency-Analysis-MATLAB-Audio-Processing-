function ProiectFTBbun
    %  CONFIGURARE FEREASTRA 
    fig = figure('Name', 'Interfata grafica', ...
        'Units', 'normalized', 'Position', [0.05 0.05 0.9 0.8], ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'Color', [0 0 0]); 
    
    data.AudioData = [];
    data.Fs = 44100;
    data.AudioFiltrat = [];
    data.PlayerObj = [];
    guidata(fig, data);

    c_back = [0.1 0.1 0.1]; 
    c_text = [1 1 1];          
    c_grid = [0.3 0.3 0.3];    
    c_neon = [0 1 0.5]; 

    %  PANOU CONTROL 
    p_ctrl = uipanel('Parent', fig, 'Title', 'PARAMETRI FILTRARE', 'FontSize', 11, ...
        'Units', 'normalized', 'Position', [0.01 0.12 0.2 0.85], ...
        'BackgroundColor', c_back, 'ForegroundColor', c_text, 'BorderType', 'line');

    uicontrol('Parent', p_ctrl, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'String', '📂 INCARCA AUDIO', 'Position', [0.1 0.88 0.8 0.08], ...
        'BackgroundColor', [0.25 0.25 0.25], 'ForegroundColor', c_text, 'Callback', @incarcaAudio_Callback);
    
    uicontrol('Parent', p_ctrl, 'Style', 'text', 'Units', 'normalized', ...
        'String', 'Frecventa START (Hz):', 'Position', [0.1 0.78 0.8 0.03], ...
        'HorizontalAlignment', 'left', 'BackgroundColor', c_back, 'ForegroundColor', c_text);
    h_low = uicontrol('Parent', p_ctrl, 'Style', 'edit', 'Units', 'normalized', ...
        'String', '300', 'Position', [0.1 0.73 0.8 0.05], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', c_neon);
    
    uicontrol('Parent', p_ctrl, 'Style', 'text', 'Units', 'normalized', ...
        'String', 'Frecventa STOP (Hz):', 'Position', [0.1 0.65 0.8 0.03], ...
        'HorizontalAlignment', 'left', 'BackgroundColor', c_back, 'ForegroundColor', c_text);
    h_high = uicontrol('Parent', p_ctrl, 'Style', 'edit', 'Units', 'normalized', ...
        'String', '1000', 'Position', [0.1 0.60 0.8 0.05], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', c_neon);
    
    uicontrol('Parent', p_ctrl, 'Style', 'text', 'Units', 'normalized', ...
        'String', 'Ordin Filtru:', 'Position', [0.1 0.52 0.8 0.03], ...
        'HorizontalAlignment', 'left', 'BackgroundColor', c_back, 'ForegroundColor', c_text);
    h_ord = uicontrol('Parent', p_ctrl, 'Style', 'popupmenu', 'Units', 'normalized', ...
        'String', {'2','4','8','16'}, 'Value', 3, 'Position', [0.1 0.47 0.8 0.05], ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', c_text);

    %  AXE 
    ax_pos = {[0.25 0.58 0.34 0.35], [0.64 0.58 0.34 0.35], [0.25 0.15 0.34 0.35], [0.64 0.15 0.34 0.35]};
    ax_h = zeros(1,4);
    for i = 1:4
        ax_h(i) = axes('Units', 'normalized', 'Position', ax_pos{i}, ...
            'Color', [0 0 0], 'XColor', 'w', 'YColor', 'w', ...
            'NextPlot', 'replacechildren', 'GridColor', c_grid, 'GridAlpha', 0.5);
        grid(ax_h(i), 'on');
    end
    ax_timp = ax_h(1); ax_bode = ax_h(2); ax_fft = ax_h(3); ax_spec = ax_h(4);

    % BUTOANE ACTIUNE
    uicontrol('Parent', p_ctrl, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'String', '⚡ APLICA FILTRUL', 'Position', [0.1 0.32 0.8 0.1], ...
        'BackgroundColor', [0 0.4 0.2], 'ForegroundColor', 'w', 'FontWeight', 'bold', ...
        'Callback', @(src, event) aplicaFiltru_Callback(src, event, h_low, h_high, h_ord, ax_timp, ax_bode, ax_fft, ax_spec));
    
    uicontrol('Parent', p_ctrl, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'String', '🔊 Play Original', 'Position', [0.1 0.20 0.8 0.06], ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', c_text, 'Callback', @(s,e) redare_Callback('orig', fig));
    
    uicontrol('Parent', p_ctrl, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'String', '🎧 Play Filtrat', 'Position', [0.1 0.12 0.8 0.06], ...
        'BackgroundColor', [0 0.3 0.5], 'ForegroundColor', 'w', 'Callback', @(s,e) redare_Callback('filt', fig));
    
    uicontrol('Parent', p_ctrl, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'String', '🛑 STOP', 'Position', [0.1 0.04 0.8 0.05], ...
        'BackgroundColor', [0.6 0.1 0.1], 'ForegroundColor', 'w', 'Callback', @(s,e) stop_Callback(fig));
h_status = uicontrol('Parent', fig, 'Style', 'text', 'Units', 'normalized', ...
    'Position', [0.25 0.02 0.7 0.05], 'String', 'Sistem Gata', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [0 1 0]);

    % FUNCTIILOR
    function incarcaAudio_Callback(~, ~)
        [file, path] = uigetfile({'*.mp3;*.wav;*.m4a', 'Audio Files'});
        if isequal(file, 0), return; end
        [data_raw, fs_raw] = audioread(fullfile(path, file));
        if size(data_raw, 2) > 1, data_raw = mean(data_raw, 2); end
        d = guidata(fig); d.AudioData = data_raw; d.Fs = fs_raw; guidata(fig, d);
        
        plot(ax_timp, (0:length(data_raw)-1)/fs_raw, data_raw, 'Color', [0 0.45 0.74]);
        title(ax_timp, 'COMPARATIE TIMP', 'Color', 'w', 'FontSize', 12);
        xlabel(ax_timp, 'Timp (s)'); ylabel(ax_timp, 'Amplitudine');
        set(h_status, 'String', ['📁 Incarcat: ', file]);
    end

    function aplicaFiltru_Callback(~, ~, hL, hH, hO, aT, aB, aF, aS)
        d = guidata(fig); if isempty(d.AudioData), return; end
        
        set(h_status, 'String', '⚙️ Se proceseaza...'); drawnow;
        
        f1 = str2double(get(hL, 'String')); f2 = str2double(get(hH, 'String'));
        pop_str = get(hO, 'String'); n = str2double(pop_str{get(hO, 'Value')});
        
        % Proiectare filtru
        [z, p, k] = butter(n, [f1 f2]/(d.Fs/2), 'bandpass');
        sos = zp2sos(z, p, k);
        
        % Aplicare filtru
        d.AudioFiltrat = sosfilt(sos, d.AudioData); guidata(fig, d);
        
        % 1. TIMP
        t = (0:length(d.AudioData)-1)/d.Fs;
        plot(aT, t, d.AudioData, 'Color', [0 0.45 0.74]); hold(aT, 'on');
        plot(aT, t, d.AudioFiltrat, 'Color', [0.85 0.33 0.1], 'LineWidth', 0.5); hold(aT, 'off');
        title(aT, 'COMPARATIE TIMP (Albastru=Orig, Rosu=Filt)', 'Color', 'w');

        % 2. BANDA DE TRECERE (Liniar)
        [h_fr, w_fr] = freqz(sos, 8192, d.Fs);
        plot(aB, w_fr, abs(h_fr), 'LineWidth', 2, 'Color', [0 0.7 1]);
        title(aB, 'BANDA DE TRECERE (Magnitudine Liniara)', 'Color', 'w');
        xlabel(aB, 'Frecventa (Hz)'); xlim(aB, [0 f2*2]); ylim(aB, [0 1.2]); grid(aB, 'on');

        % 3. FFT
        L = min(length(d.AudioFiltrat), 65536);
        f_vec = d.Fs*(0:(L/2))/L;
        Y_filt = abs(fft(d.AudioFiltrat(1:L))/L);
        plot(aF, f_vec, Y_filt(1:length(f_vec)), 'Color', [1 0.9 0]);
        title(aF, 'SPECTRUL FRECVENTA (FFT)', 'Color', 'w');
        xlim(aF, [0 f2*2.5]); grid(aF, 'on');

        % 4. SPECTROGRAMA (HEATMAP)
        cla(aS); 
        samples_spec = min(length(d.AudioFiltrat), round(d.Fs*5));
        [S, F, T_s] = spectrogram(d.AudioFiltrat(1:samples_spec), 1024, 800, 1024, d.Fs);
        imagesc('Parent', aS, 'XData', T_s, 'YData', F, 'CData', 20*log10(abs(S) + eps));
        
        set(aS, 'YDir', 'normal'); 
        colormap(aS, 'hot'); 
        title(aS, 'SPECTROGRAMA (HEATMAP)', 'Color', 'w', 'FontSize', 12);
        xlabel(aS, 'Timp (s)'); ylabel(aS, 'Frecventa (Hz)');
        ylim(aS, [0 d.Fs/2]); 
        
        set(h_status, 'String', '✅ Filtrare finalizata.');
        drawnow;
    end

    function redare_Callback(tip, f_handle)
        d = guidata(f_handle);
        snl = d.AudioData; if strcmp(tip, 'filt'), snl = d.AudioFiltrat; end
        if isempty(snl), return; end
        if ~isempty(d.PlayerObj), stop(d.PlayerObj); end
        d.PlayerObj = audioplayer(snl, d.Fs); guidata(f_handle, d); play(d.PlayerObj);
    end

    function stop_Callback(f_handle)
        d = guidata(f_handle); if ~isempty(d.PlayerObj), stop(d.PlayerObj); end
    end
end