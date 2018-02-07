

a = Scale.superLocrian;
a.ratios

Ndef(\sl).play(fadeTime: 5);
Ndef(\sl).fadeTime = 3.1;

Ndef(\t, { Impulse.kr(MouseX.kr(1, 4)*4) });
(
Ndef(\sl, { arg freq=440, amp=0.01;
	var t, env, snd, freqs, snd2;
	t = Ndef(\t).kr;
	freqs = freq * a.ratios;
	freqs = Dseq(freqs, inf);
	freqs = Demand.kr(t, 0, freqs);
	freqs = freqs * [1, 1.01] * [1, a.ratios[5]];
	freqs = freqs * Demand.kr(t, 0, Drand([1, 1, 2, 1, 0.5, 0.25], inf));
	snd = LFPulse.ar(freq: freqs, iphase: 0, width: LFNoise0.kr(1/2).range(0.1, 0.6));
	snd = snd * amp;
	snd = LPF.ar(snd, [LFSaw, SinOsc].choose.ar(MouseX.kr(1, 4)).range(1000, 4000));
	snd = snd.distort;
	env = SinOsc.ar([LFNoise2, LFNoise0].choose.ar(3).range(1, 13));
	snd2 = snd+ CombC.ar(snd, 1, 0.54, 2);
	snd = snd * env;
	// snd2 = snd + PitchShift.ar(snd2, 0.2, LFSaw.kr(1).range(0.9, 1), 0.0, MouseY.kr(0, 0.3), 2);
	snd =snd + (snd2 /** 0.5*/);
	snd = Splay.ar(snd);
	// snd = HPF.ar(snd, XLine.kr(50, 15000, 40)) * XLine.kr(1, 0.01, 60);
})
)

Ndef(\sl).clear(15);
	
