MIDIClient.init;

m = MIDIOut(0);

t = TempoClock.new(60/60);

(
Pbindef(\organ,
	\type, \midi,
	\scale, Scale.harmonicMinor,
	\degree, Pshuf([0, 1, 2, 3, 4, 5, 6, 7], inf) + [0, 2, 4] + 24,
	\dur, 0.5, 
	\amp, Pwhite(0.01, 0.1), 
	\legato, 0.3,
	\midiout, m
).play(t, quant: 1);
)

Pbindef(\organ, \amp, 0.01);

Pbindef(\organ).stop;

(
Pbindef(\organ2,
	\type, \midi,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 9, 11, 14].reverse, inf),
	\ctranspose, [-12, 7, 0],
	\dur, 0.25, 
	\amp, Pwhite(0.1, 0.4), 
	\midiout, m
).play(t, quant: 1);
)

Pbindef(\organ2, \ctranspose, [-12], \dur, 0.125);

Pbindef(\organ2, \mtranspose, Prand([0, 0, 0, 0, -5], inf));

Pbindef(\organ2, \legato, 0.7);

Pbindef(\organ2, \amp, 0.01);

(
Pbindef(\organ3,
	\type, \midi,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, -2, -5, -4, -3, -7], inf),
	\ctranspose, -24,
	\dur, 4, 
	\amp, 0.65, 
	\legato, 1,
	\midiout, m
).play(t, quant: 1);
)


Pbindef(\organ).stop;
Pbindef(\organ2).stop


(
Pbindef(\more, 
	\type, \midi, 
	\scale, Scale.harmonicMinor, 
	\degree, Pseq([
		[0, 2, 4],
		[1, 3, 5],
		[2, 4, 6, 8],
		[3, 4, 6, 8, 9],
	], inf),
	\dur, 4,
	\amp, 0.5, 
	\legato, 0.5,
	\midiout, m
).play(t, quant: 1)
)

Pbindef(\more).stop;
(
var amp = 0.1;
Pbindef(\more, \amp, amp/12);
Pbindef(\organ3, \amp, amp)
)
