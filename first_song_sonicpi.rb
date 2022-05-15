/
1.times do
  with_fx :flanger, feedback: 1 do
    garzul_feed = sample :loop_garzul, cutoff: 100, cutoff_slide: 4
    control garzul_feed, cutoff: 60
  end
  sleep (sample_duration :loop_garzul) + 1.05
end
/

live_loop :slowbass do
  with_fx :flanger, feedback: 0 do
    garzul = sample :loop_garzul, cutoff: 110, cutoff_slide: 2
    control garzul, cutoff: 130
  end
  use_synth :prophet
  play (ring :e1, :d1).tick, release: 8, cutoff: (ring 70, 80, 80, 90, 70).look
  sleep 8
end



/
live_loop :melody do
  use_synth :pluck
  use_synth_defaults sustain: 0, release: 2, release_slide: 0.5, amp: 0.5
  notes = (scale :e4, :minor_pentatonic).take(4).stretch(3)
  with_fx :ping_pong do
    with_fx :echo, phase: 0.5, phase_slide: 0.25  do |e|
      x = play notes.tick
      sleep (ring 0.25, 0.25, 0.5).look
      control e, phase: 0.25
    end
  end
end
/


/ Bass Arrays and functions /

define :onbeat_bass do
  #4 beats
  8.times do
    sample :bass_hit_c
    sleep 0.5
  end
end


/              1 + 2 + 3 + 4 + 1 + 2 + 3 + 4 +   /
bass1_beat =  [1,0,1,0,1,0,1,0,1,0,0,1,0,0,1,0]
snare_beat =  [1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0]
/------------------------------------------------/
bass2_beat =  [0,1,0,1,1,0,1,0,1,0,1,1,0,1,1,0]
snare2_beat = [0,0,1,0,1,1,0,1,0,0,1,1,0,1,0,1]

define :bass1 do
  #4 beats
  with_fx :krush do
    16.times do |i|
      sample :bass_hit_c if bass1_beat[i] == 1
      sample :sn_generic if snare_beat[i] == 1
      sleep 0.25
    end
  end
  
end

define :bass2 do
  16.times do |i|
    with_fx :octaver do
      sample :bass_hit_c if bass2_beat[i] == 1
    end
    
    with_fx :krush do
      
      sample :sn_generic if snare2_beat[i] == 1
    end
    
    sleep 0.25
  end
end


define :hihat16 do
  
  32.times do
    sample :drum_cymbal_closed, release: 0.1, sustain: 0, amp: 0.75
    sleep 0.25
  end
  
  32.times do
    sleep_times = (ring 0.25, 0.5, 0.25, 0.25, 0.25, 0.5, 0.25, 0.5)
    sample :drum_cymbal_closed, release: 0.1, sustain: 0, amp: 0.75
    sleep sleep_times.tick
  end
  
end



/
live_loop :bass do

  1.times do

    onbeat_bass

  end

  3.times do

    bass1
  end

  1.times do

    bass2
  end
end
/


/
live_loop :hihat do
  hihat16
end
/

/MAIN ARRANGEMENT ----------------------------------------/





/---------------------------------------------------------/

