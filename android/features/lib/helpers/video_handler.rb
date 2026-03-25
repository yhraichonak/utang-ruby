
class VideoHandler

  def initialize
    $video_path = nil
    $video_edit_path = nil
  end

  def cut_and_save_video(path_to_video, edit_path, final_sec=50)
    duration = `ffmpeg -i "#{path_to_video}" 2>&1 | grep "Duration"`.split('Duration: ')[1].split(', ')[0]
    dur = duration.split(':')
    puts dur[2].to_i
    if dur[0] == '00' && dur[1] == '00' && dur[2].to_i <= final_sec.to_i+1
      puts "[VIDEO] Video length OK. Less than %s sec." % final_sec
    else
      puts "[VIDEO] Slicing video duration to last %s sec..." % final_sec
      `ffmpeg -sseof -#{final_sec} -i "#{path_to_video}" "#{edit_path}"`
      `rm "#{path_to_video}"`
    end
  end
end