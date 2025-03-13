import 'package:flutter/material.dart';
import 'package:spotoffline/core/utils.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/presentation/screens/lyrics_screen.dart';

const lyrics = '''
They say, "The holy water's watered down\n
And this town's lost its faith\n
Our colors will fade eventually"\n
So, if our time is runnin' out\n
Day after day\n
We'll make the mundane our masterpiece\n
Oh my, my\n
Oh my, my love\n
I take one look at you\n
You're takin' me out of the ordinary\n
I want you layin' me down 'til we're dead and buried\n
On the edge of your knife, stayin' drunk on your vine\n
The angels up in the clouds are jealous knowin' we found\n
Somethin' so out of the ordinary\n
You got me kissin' thе ground of your sanctuary\n
Shatter me with your touch, oh Lord, return mе to dust\n
The angels up in the clouds are jealous knowin' we found\n
Hopeless hallelujah\n
On this side of Heaven's gate\n
Oh, my life, how do ya\n
Breathe and take my breath away?\n
At your altar, I will pray\n
You're the sculptor, I'm the clay\n
Oh my, my\n
You're takin' me out of the ordinary\n
I want you layin' me down 'til we're dead and buried\n
On the edge of your knife, stayin' drunk on your vine\n
The angels up in the clouds are jealous knowin' we found\n
Somethin' so out (Out) of the ordinary (Ordinary)\n
You got me kissing the ground (Ground) of your sanctuary (Sanctuary)\n
Shatter me with your touch, oh Lord, return me to dust\n
The angels up in the clouds are jealous knowin' we found\n
Somethin' so heavenly, higher than ecstasy\n
Whenever you're next to me, oh my, my\n
World was in black and white until I saw your light\n
I thought you had to die to find\n
Somethin' so out of the ordinary\n
I want you laying me down 'til we're dead and buried\n
On the edge of your knife, stayin' drunk on your vine\n
The angels up in the clouds are jealous knowin' we found\n
Somethin' so out (Out) of the ordinary\n
You got me kissing the ground (Ground) of your sanctuary (Sanctuary)\n
Shatter me with your touch, oh Lord, return me to dust\n
The angels up in the clouds are jealous knowin' we found\n
''';

class LyricsCard extends StatelessWidget {
  const LyricsCard({
    super.key,
    required this.track,
  });
  final Track track;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          Row(
            children: [
              const Text(
                'Lyrics',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => slideInNavigate(context,
                    LyricsScreen(track: track.copyWith(lyrics: lyrics))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.black45),
                  child: const Icon(
                    Icons.open_in_full_outlined,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Expanded(
            child: Text(
              lyrics,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
