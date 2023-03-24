const LETTERS = "ABCDEFHIJKLMNOPQRSTUVWXYZ";
const SENTENCE_ENDING = ".?!";

const sentences = (data, feed, ctx) => {
    if (ctx.isLast()) {
        return feed.close();
    }

    let value = data?.value;
    if (Array.isArray(value)) {
        if (value.length === 1) {
            value = value[0];
        }
    }
    if (typeof value !== 'string') {
        return feed.send({ ...data, value });
    }

    value = value.split("").reduce((a, c) => {
        const currentSentence = a.slice(-1);
        const [prev1, prev2] = a.slice(-1)[0].slice(-2);
        if (SENTENCE_ENDING.includes(c)) {
            if (c !== ".") {
                return [...a.slice(0, -1), (currentSentence + c).trimStart(), "  "];
            }

            if (prev1 !== " ") {
                return [...a.slice(0, -1), (currentSentence + c).trimStart(), "  "];
            }

            if (!LETTERS.includes(prev2)) {
                return [...a.slice(0, -1), (currentSentence + c).trimStart(), "  "];
            }
        }
        return [...a.slice(0, -1), currentSentence + c]
    },
        ["  "])
        .filter(sentence => sentence !== "  ")
        .map(s => s.trimStart());
    feed.send({ ...data, value });
};

module.exports = {
    sentences,
};
