//
//  HTMLView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/2/21.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    
    init(htmlString: String) {
        self.htmlString = htmlString
    }
    
    let htmlString: String
    
    func makeUIView(context: Context) -> UITextView {
        let label = UITextView()
        
        label.attributedText = htmlString.htmlAttributedString()
        return label
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) { }
}

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <meta charset=UTF-8>
        <html>
          <head>
            <style>
              body {
                font-family: -apple-system;
                font-size: 24px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(htmlString: """
            
            <p>As most Redwood students may know, Redwood’s competitive dance team known as Dance Force is not easy to make. However, two of our very own freshmen have managed to do so. Gwyneth Miller, ’25 and Marileigh Coon, ’25 have not only been dancing together for about 12 years, but now have been given the privilege and opportunity to continue each other’s friendship through the Redwood Dance Force team.</p><p>As most Redwood students may know, Redwood’s competitive dance team known as Dance Force is not easy to make. However, two of our very own freshmen have managed to do so. Gwyneth Miller, ’25 and Marileigh Coon, ’25 have not only been dancing together for about 12 years, but now have been given the privilege and opportunity to continue each other’s friendship through the Redwood Dance Force team.



            </p><p>As most Redwood students may know, Redwood’s competitive dance team known as Dance Force is not easy to make. However, two of our very own freshmen have managed to do so. Gwyneth Miller, ’25 and Marileigh Coon, ’25 have not only been dancing together for about 12 years, but now have been given the privilege and opportunity to continue each other’s friendship through the Redwood Dance Force team.



            Miller at the icebreaker rally</p><p>As most Redwood students may know, Redwood’s competitive dance team known as Dance Force is not easy to make. However, two of our very own freshmen have managed to do so. Gwyneth Miller, ’25 and Marileigh Coon, ’25 have not only been dancing together for about 12 years, but now have been given the privilege and opportunity to continue each other’s friendship through the Redwood Dance Force team.



            Miller at the icebreaker rally</p><p>As most Redwood students may know, Redwood’s competitive dance team known as Dance Force is not easy to make. However, two of our very own freshmen have managed to do so. Gwyneth Miller, ’25 and Marileigh Coon, ’25 have not only been dancing together for about 12 years, but now have been given the privilege and opportunity to continue each other’s friendship through the Redwood Dance Force team.



            Miller at the icebreaker rally</p><p>According to Miller, she has been dancing for almost 12 years now, most of those years being at the competitive dance program, Dance Arts. Miller’s favorite part about dancing through all these years has been her ability to “see [herself] improve.” She adds, “Every move you make feels different than the last. It’s really interesting to experiment with things and finally find what works and looks the best.”</p><p>Making the Dance Force team is a huge accomplishment for any dancer who makes it, let alone being a freshman. Having the honor of being one of the two to do so, Miller says, “It feels awesome… dance is something I’m really passionate about, so I’m excited to be challenged this year with this class.”</p><p>“This team has a really strong bond. It feels more like spending time with your closest family friends. I really love how we encourage each other, and lift each other up.”</p><p>“This team has a really strong bond. It feels more like spending time with your closest family friends. I really love how we encourage each other, and lift each other up.”Gwyneth Miller, ’24</p><p>“This team has a really strong bond. It feels more like spending time with your closest family friends. I really love how we encourage each other, and lift each other up.”Gwyneth Miller, ’24</p><p>This being her first official year not only as a Redwood Ranger, but as a Dance Force member, Miller is most looking forward to dancing at a football game. She says, “I have been to Redwood football games as a spectator, but I’m excited to see how it will feel to actually be down on the field.”</p><p>This being her first official year not only as a Redwood Ranger, but as a Dance Force member, Miller is most looking forward to dancing at a football game. She says, “I have been to Redwood football games as a spectator, but I’m excited to see how it will feel to actually be down on the field.”

            </p>

            
            
            """
            )
    }
}
