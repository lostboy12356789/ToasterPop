
import UIKit

class VideoModel: NSObject {
    func getVideos() -> [Video] {
        var videos = [Video]()

        let video1 = Video()
        video1.videoId = "48kekFLZkXU"
        video1.videoTitle = "Video 1 Title"
        video1.videoDescription = "Video 1 Description"
        videos.append(video1)

        let video2 = Video()
        video2.videoId = "48kekFLZkXU"
        video2.videoTitle = "Video 1 Title"
        video2.videoDescription = "Video 1 Description"
        videos.append(video2)

        let video3 = Video()
        video3.videoId = "48kekFLZkXU"
        video3.videoTitle = "Video 1 Title"
        video3.videoDescription = "Video 1 Description"
        videos.append(video3)


        let video4 = Video()
        video4.videoId = "48kekFLZkXU"
        video4.videoTitle = "Video 1 Title"
        video4.videoDescription = "Video 1 Description"
        videos.append(video4)

        return videos
    }
}
