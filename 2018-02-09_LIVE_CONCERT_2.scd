// how is everyone doing
// these red lines are just comments, they don't make any sound
// fear not
// I may talk to you a bit during the performance using this
// or maybe not
// we'll see

// let's start with a scale

a = Scale.major; // why not
a.tuning = \just; // uuuhhhhhhhh
//oops error message
// better
// ok

// let's see

Ndef(\chord).play(fadeTime: 10);
Ndef(\chord).fadeTime = 4;
(
~chord = {
	Ndef(\chord, {arg freq=200, amp=0.2;
		var snd,snd2,  env, freqs;
		env = LFTri.ar(1/[1, 2, 3, 5, 7]).range(0.1, 1);
		// trying to get to a nice chord here
		freqs = freq * a.ratios * [1, 1.01, 1.005] * [1/2, 1/2, 1/2, 1/2, 2, 4].scramble;
		freqs = freqs * Ndef.kr(\gliss);
		snd = SinOsc.ar(freqs, mul: env * amp);
		snd2 = LFSaw.ar(freqs, mul: env * amp);
		snd = SelectX.ar(LFNoise2.ar(1/2).range(0, 1), [snd, snd2]);
		snd = Splay.ar(snd);
		// as you can see it takes a while to get going
		// but we are not afraid of silence, are we?
})
}
)

Ndef(\gliss, { Line.kr(1, 0.5, 60) })

// let's automate these chord changes
(
~chordChange.stop;
~chordChange = { 100.do{ |i| ~chord.value; i.postln; rrand(2, 6).wait } }.fork;
)

// I need a plainchant now
(
~mel = {
	Ndef(\mel, {arg freq=1000, amp=0.005;
		var freqs, snd;
		freqs = freq + [0, 0, 0, 100, 200, -100, -200, 500, -300].choose * [1, 1.01, 0.999, 1.5, 0.5] / 2;
		freqs = freqs + SinOsc.ar(MouseY.kr(1, 3)).range(-10, 10);
		freqs = freqs * Ndef.kr(\gliss);
		snd = LFPulse.ar(freqs, width: LFNoise2.ar(1).range(0.1, 0.9));
		// snd = snd * LFPulse.ar([1, 2, 4], width: 0.5).range(0.0, 1);
		snd = LPF.ar(snd, SinOsc.ar(1/2).range(500, 1000));
		// snd = LFTri.ar(1/3).range(0.0, 0) * snd;

		snd = Splay.ar(snd) * 0.0;
})
}
)

Ndef(\mel).play(fadeTime: 10);
Ndef(\mel).fadeTime = 0.2;

(
~melChange.stop;
~melChange = { inf.do{ |i| ~mel.value; ["mel", i].postln; rrand(1/3, 2).wait } }.fork;
)


(Ndef(\fx, {
	var snd = Ndef.ar(\mel);
	snd = snd * LFPulse.ar(1/5, width: 0.1).range(0, 1/2);
	snd = CombC.ar(snd, 1, 0.4, 2) + snd;
	Splay.ar(snd);
}).play(fadeTime: 4)
)


Ndef(\chord).clear(30)








// now if I run this again, it will change a few octaves
























