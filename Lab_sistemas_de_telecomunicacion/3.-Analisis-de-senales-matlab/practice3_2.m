% Example:
    %   View the power spectrum of a noisy sine wave on Spectrum Analyzer.

    a = 1; % Amplitude
    f = 10; % Frequency (Hertz)
    w = 2 * pi * f;
    v = a * sin(w * t);
    swv = dsp.SineWave('Frequency',100, 'SampleRate', 1000); % DSP: Digital Signal Processor
    swv.SamplesPerFrame = 1000;
    san = dsp.SpectrumAnalyzer('SampleRate', swv.SampleRate);
    for ii = 1:250
      x = swv() + 0.05*randn(1000,1);
      san(x);
    end
    release(san);