import librosa
import numpy as np
import soundfile
import matplotlib.pyplot as plt


def apply_fadeout(audio):
    length = audio.shape[0]
    fade_curve = np.ones(length) - np.linspace(0.001, 1, length)
    return audio * fade_curve


def apply_fadein(audio):
    length = audio.shape[0]
    fade_curve = np.ones(length) - np.linspace(1, 0.001, length)
    return audio * fade_curve

def compile_song(audio1, audio2, sr, fade, start, end):
  dur = int(fade*sr)
  fadeout = apply_fadeout(audio1[end-dur:end])
  fadein = apply_fadein(audio2[start:start+dur])
  transition = np.add(fadein, fadeout)
  song = np.concatenate((audio1[0:end-dur], transition, audio2[start+dur:]))
  soundfile.write('compilation.mp3', song, samplerate=sr)

def tempoCalc(audio, sr):
  tempo, _ = librosa.beat.beat_track(y=audio, sr=sr)
  return tempo

def startstopPoint(audio1, audio2, sr, time):
  dist = float(np.Infinity)
  end = audio1.size
  start = 0
  frame = time*sr
  for i in range(0, sr*40, sr):
    low = sum(audio2[i:frame+i])
    high = sum(audio1[audio1.size-(i+frame):audio1.size-i])
    diff = high-low
    if diff < dist and low/frame > 0:
      dist = diff
      end = audio1.size-i
      start = i
  return start, end

def compileSong():
  audio1, sr1 = librosa.load("/content/WishKnwU.mp3")
  tempo1 = tempoCalc(audio1, sr1)

  audio2, sr2 = librosa.load("/content/MtnSound.mp3")
  tempo2 = tempoCalc(audio2, sr2)

  fade = int((tempo1 + tempo2) / 13)
  start, end = startstopPoint(audio1, audio2, sr1, fade)
  compile_song(audio1, audio2, sr1, fade, start, end)

compileSong()