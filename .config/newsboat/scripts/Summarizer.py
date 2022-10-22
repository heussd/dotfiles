from array import array
import re
import sys

from pysummarization.abstractabledoc.top_n_rank_abstractor import TopNRankAbstractor
from pysummarization.nlpbase.auto_abstractor import AutoAbstractor
from pysummarization.tokenizabledoc.simple_tokenizer import SimpleTokenizer


def remove_html(text):
    return re.sub('<[^<]+?>', '', text)


def summarize(document):
    summary = []
    auto_abstractor = AutoAbstractor()
    auto_abstractor.tokenizable_doc = SimpleTokenizer()
    auto_abstractor.delimiter_list = [".", "\n"]
    # Object of abstracting and filtering document.
    abstractable_doc = TopNRankAbstractor()

    result_dict = auto_abstractor.summarize(document, abstractable_doc)

    scoring = result_dict["scoring_data"]
    scoring.sort(key=lambda x: x[1], reverse=True)
    scoring = scoring[0:5]

    for i in range(0, len(scoring)):
        index, score = result_dict["scoring_data"][i]

        if index < len(result_dict["summarize_result"]):
            sentence = result_dict["summarize_result"][index].strip()
            summary.append("[Score " + str(round(score)) + "] " + sentence)
    
    return summary


def pretty_print(summary: array):
    for s in summary:
        print(s, "\n")


if __name__ == "__main__":
    input_text = ""
    for line in sys.stdin:
        input_text = input_text + "\n" + line

    pretty_print(
        summarize(
            remove_html(
                input_text
            )
        ))
