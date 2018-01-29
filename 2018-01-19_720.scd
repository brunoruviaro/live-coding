

a = Scale.major;
a.tuning_(\just);

a.ratios

Ndef(\chord).play;
Ndef(\chord).fadeTime = 4;

(
c.clear;
c = SystemClock.sched(0, {
	Ndef(\chord, { arg freq=220,amp=0.31;
		var snd, env, snd2;
		env = LFPulse.kr(a.ratios * [1, 2, 1/2]).range(0.3, 0.7) * amp;
		freq = freq * a.ratios * [1, 1, 2, 1].scramble;
		snd =SinOsc.ar(freq, mul: env);
		snd2 =BPF.ar(LFPulse.ar(freq*2, mul: env), LFNoise2.kr(1.3).range(1000, 2345), 0.1);

		snd = Splay.ar(snd);
		snd2 = Splay.ar(snd2);

		snd = snd.distort.distort;
		snd = snd + (snd2*0.5);
		snd = snd + (CombC.ar(snd2, 3, LFNoise0.kr(1/5).range(0.4, 3), LFNoise0.kr(1/6).range(1/2, 3), SinOsc.kr(1/4)));
		snd = Splay.ar(snd);
		snd = FreeVerb.ar(snd, 0.2, 0.5);
	});
	rrand(2, 5);
})
)

c.clear;





(
Ndef(\chord, { arg freq=220,amp=0.1;
	var snd, oct, imp;
	imp = Impulse.kr(1);
	oct = Demand.kr(imp, imp, Dseq([[1, 1, 2, 1].scramble], 1));
	freq = freq * a.ratios * oct; //Lag.kr(Ndef(\oc), 0.2);
	snd =SinOsc.ar(freq, mul: amp);
	snd = Splay.ar(snd);

})
)

Ndef(\oc, { [1, 2, 1, 1].scramble });

Ndef(\chord).set(\oct, 1);

Ndef(\chord).set(\freq, 220, \amp, 0.3);

