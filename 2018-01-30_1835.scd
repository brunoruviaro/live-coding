a = Scale.major;
a.tuning = \just;

Ndef(\chord).play(fadeTime: 6);
Ndef(\chord).fadeTime = 4;

(
f = {
Ndef(\chord, {arg freq=100, amp=0.1;
	var snd, env, snd2, env2, freqs;
	freqs = freq * a.ratios * [1, 1.5, 1, 1, 2, 4].scramble * [1, 1.01];
	env = SinOsc.kr(1/[2, 4, 7, 9].scramble) * amp;
	snd = LFTri.ar(freqs, mul: env);
		env2 = LFTri.kr(1/[3, 5, 6, 11].scramble) * amp;
	snd2 = LFSaw.ar(freqs, mul: env2);
		snd2 = BPF.ar(snd2, [1509, 2450, 2900, 5600] + [SinOsc, LFPulse].choose.ar([1/4, 1/7,  2].choose).range(-400, 400), rrand(0.05, 0.3));
	snd2 = LPF.ar(snd2, 3000);
	snd = SelectX.ar(LFNoise2.ar(1/5).range(0.1, 0.9), [snd, snd2]);
	snd = Splay.ar(snd) * 0.6;
})
};
)

(
~chordChange.stop;
~chordChange = { 100.do{ arg i; f.value; i.postln; rrand(1, 6).wait } }.fork;
)



Ndef(\mel).play(fadeTime: 10);

(
~mel={
Ndef(\mel, {arg freq=1000, amp=0.02;
	var snd, env;
		freq = freq + [-500, -100, 100, 0, 0, 200, 500, 800].choose * [1, 1.01, 1.011, 0.99] * \gliss.kr(1);
	freq = freq + SinOsc.ar(LFNoise2.ar(1/4).range(5, 8)).range(freq/100 * 1.neg, freq/100);
		freq = freq * LFSaw.ar(1/2).range(1, 1.1);
	snd = LFPulse.ar(freq, width: rrand(0.2, 0.6));
		snd = snd * [LFTri, LFPulse, SinOsc].choose.ar(rrand(1, 3) * MouseX.kr(2, 7)).range(0.02, 0.6);
	snd =Splay.ar(snd) * amp;
		snd = CombL.ar(snd, 1, 0.6, 3) + snd;
}
)
}
)

Ndef(\gliss, { Line.kr(1, 12, 50) });
Ndef(\mel).map(\gliss, Ndef(\gliss));
(
~melChange.stop;
~melChange = { 50.do{~mel.value; rrand(1/3, 2).wait} }.fork;
)


Ndef(\rev).fadeTime = 4;

(
Ndef(\rev, {
	var in, snd, snd2;
	in = In.ar(0, 2);
	snd = FreeVerb.ar(in,0.1, 0.6, 0.5);
	snd = snd + CombN.ar(snd, 1, 0.8, 3);
	snd2 = PitchShift.ar(snd, 0.2, SinOsc.ar(1/3).range(0.5, 1.1));
	snd = ReplaceOut.ar(0, snd+snd2);
})
)

Ndef.clear(30);