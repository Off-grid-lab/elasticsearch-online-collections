FROM elasticsearch:8.6.1

WORKDIR /usr/share/elasticsearch
RUN elasticsearch-plugin install https://github.com/vhyza/elasticsearch-analysis-lemmagen/releases/download/v8.6.1/elasticsearch-analysis-lemmagen-8.6.1-plugin.zip
RUN mkdir -p config/lemmagen
RUN curl -Lso config/lemmagen/sk.lem https://github.com/vhyza/lemmagen-lexicons/raw/master/free/lexicons/sk.lem
RUN curl -Lso config/lemmagen/cs.lem https://github.com/vhyza/lemmagen-lexicons/raw/master/free/lexicons/cs.lem
RUN curl -Lso config/lemmagen/en.lem https://github.com/vhyza/lemmagen-lexicons/raw/master/free/lexicons/en.lem

# grab sng elasticsearch repository - will make proper directory structure inside config
RUN curl -Ls https://github.com/SlovakNationalGallery/elasticsearch-slovencina/archive/master.tar.gz | tar xz -C config --strip-components=1

# grab extra synonym files and save them inside config/synonyms
RUN curl -Ls http://wordnetcode.princeton.edu/3.0/WNprolog-3.0.tar.gz | tar xz -C config/synonyms --strip-components=1 prolog/wn_s.pl

# TODO remove these
ADD synonyms_cz.txt config/synonyms/synonyms_cz.txt
ADD stopwords_cz.txt config/stop-words/stop-words-czech2.txt