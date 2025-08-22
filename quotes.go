package main

import (
	"math/rand"
	"time"
)

var navalQuotes = []string{
	"Seek wealth, not money or status. Wealth is having assets that earn while you sleep.",
	"You're not going to get rich renting out your time. You must own equity to gain your financial freedom.",
	"Learn to sell. Learn to build. If you can do both, you will be unstoppable.",
	"Arm yourself with specific knowledge, accountability, and leverage.",
	"Specific knowledge is knowledge that you cannot be trained for.",
	"Play iterated games. All the returns in life come from compound interest.",
	"Pick business partners with high intelligence, energy, and, above all, integrity.",
	"Don't partner with cynics and pessimists. Their beliefs are self-fulfilling.",
	"Learn to love to read. Reading is the ultimate meta-skill.",
	"The most important skill for getting rich is becoming a perpetual learner.",
	"Embrace accountability, and take business risks under your own name.",
	"There are no get rich quick schemes. That's just someone else getting rich off you.",
	"You will get rich by giving society what it wants but does not yet know how to get.",
	"If you secretly despise wealth, it will elude you.",
	"Ignore people playing status games. They gain status by attacking people playing wealth creation games.",
	"You're not going to get rich renting out your time.",
	"Code and media are permissionless leverage.",
	"Most of life is a search for who and what needs you the most.",
	"The Internet has massively broadened the possible space of careers.",
	"Escape competition through authenticity.",
	"Doing one thing better than anyone else is the key to wealth.",
	"Apply specific knowledge, with leverage, and eventually you will get what you deserve.",
	"When you're finally wealthy, you'll realize that it wasn't what you were seeking in the first place.",
	"Earn with your mind, not your time.",
	"Become the best in the world at what you do. Keep redefining what you do until this is true.",
	"School, politics, sports, and games train us to compete against others. True rewards come from competing against yourself.",
	"The most interesting people are the ones who don't fit into your average box.",
	"Happiness is a choice and a skill and you can dedicate yourself to learning that skill.",
	"Desire is a contract that you make with yourself to be unhappy until you get what you want.",
	"Happiness is being present and not thinking about the past or future.",
	"Peace is happiness at rest. Happiness is peace in motion.",
	"The three big ones in life are wealth, health, and happiness. We pursue them in that order, but their importance is reverse.",
	"All the real benefits in life come from compound interest.",
	"Play long-term games with long-term people.",
	"Life is a single-player game.",
	"Jealousy is a pointless emotion.",
	"You can't be normal and expect abnormal returns.",
	"Reading is faster than listening. Doing is faster than watching.",
	"Busy is the death of productivity.",
	"The modern mind is overstimulated and the modern body is understimulated.",
	"Art is creativity. Art is anything done for its own sake.",
	"Money is how we transfer time and wealth. Money is social credits.",
	"You make your own luck if you stay at it long enough.",
	"Karma is just you, repeating your patterns, virtues, and flaws until you finally get what you deserve.",
	"Doctors won't make you healthy. Teachers won't make you smart. Gurus won't make you calm. You have to do it yourself.",
	"A fit body, a calm mind, a house full of love. These things cannot be bought—they must be earned.",
	"Technology is the application of knowledge to control the natural world.",
	"Retirement is when you stop sacrificing today for an imaginary tomorrow.",
	"If you can't see yourself working with someone for life, don't work with them for a day.",
	"Reading a book isn't a race – the better the book, the slower it should be absorbed.",
}

type Quote struct {
	Text   string
	Author string
}

func init() {
	rand.Seed(time.Now().UnixNano())
}

func GetRandomQuote() Quote {
	index := rand.Intn(len(navalQuotes))
	return Quote{
		Text:   navalQuotes[index],
		Author: "- Naval Ravikant",
	}
}

func GetMultipleQuotes(count int) []Quote {
	if count > len(navalQuotes) {
		count = len(navalQuotes)
	}
	
	quotes := make([]Quote, 0, count)
	used := make(map[int]bool)
	
	for len(quotes) < count {
		index := rand.Intn(len(navalQuotes))
		if !used[index] {
			quotes = append(quotes, Quote{
				Text:   navalQuotes[index],
				Author: "- Naval Ravikant",
			})
			used[index] = true
		}
	}
	
	return quotes
}