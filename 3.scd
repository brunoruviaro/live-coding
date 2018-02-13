m = MIDIOut(0);

t = TempoClock.new(60/60);

// last piece.

// when I was a kid I wanted to be an organ player.
// I ended up playing the piano instead
// still do, and love it
// but that organist inside of me decided to come to stage tonight.

(
Pbindef(\organ0,
	\type, \midi,
	\midiout, m,
	\chan, 0,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([7, 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, 1,
	\amp, Pwhite(0.5, 0.9)
).play(t, quant: 4)
)

(
Pbindef(\organ1,
	\type, \midi,
	\midiout, m,
	\chan, 1,
	\scale, Scale.harmonicMinor,
	\degree, Prand([Pwhite(6, 8, 1), 0, 1, 2, 3, 4, 5, 6].reverse, inf),
	\dur, 1/4,
	\ctranspose, -12,
	\amp, Pseq([0.4, Pn(0.2, 7)], inf) * 2,
	\legato, Pwhite(0.3, 0.6)
).play(t, quant: 4)
)

(
Pbindef(\organ2,
	\type, \midi,
	\midiout, m,
	\chan, 2,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([Pwhite(7, 10, 1), 0, 1, 2, 3, 4, 5, 6], inf),
	\dur, Prand([1/6, 1/6, 1/6, 1/3, Rest(1/3)], inf) * 2,
	\ctranspose, [7, 12, 16],
	\amp, Pseq([0.4, Pn(0.2, 7)], inf),
	\legato, Pwhite(0.4, 0.8)
).play(t, quant: 4)
)

(
Pbindef(\organ4,
	\type, \midi,
	\midiout, m,
	\chan, 3,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, -2, -5, -4, -3, -7	], inf),
	\dur, 4,
	\ctranspose, [-24, -12, 0],
	\amp, 0.6,
	\legato, 0.96
).play(t, quant: 4)
)

Pbindef(\organ3, \amp, 0.5);

(
Pbindef(\organ3,
	\type, \midi,
	\midiout, m,
	\chan, 3,
	\scale, Scale.harmonicMinor,
	\degree, Pseq([
		[0, 2, 4],
		[1, 3, 5],
		[2, 4, 6, 8],
		[3, 4, 6, 9]
	], inf),
	\dur, Pseq([4, 2, 4, 6], inf),
	\ctranspose, 0,
	\amp, 0.6,
	\legato, Pwhite(0.5, 0.9),
).play(t, quant: 4)
)


Pbindef.all.keys.do{ arg k; Pbindef(k, \legato, Pwhite(0.05, 0.1), \amp, 0.00) };







	