# EAST - Echolocation Audio Spectrogram Transformer
Self-Supervised Audio Spectrogram Transformer (SSAST) adapted to predict a bat's chirp frequency, given a spectrogram of the previous chirp

In the following work we construct a state of the art machine learning model capable of predicting the main frequency of the next-in-line bat chirp, when given a current chirp's spectrogram. Thus the model is in-fact able to perform Doppler shift compensation.
This work is based on the adoption of an earlier audio classification work where researchers have created an Audio Spectrogram Transformer model, and a matching self supervised framework for the model to achieve good understanding of spectrograms (https://github.com/YuanGongND/ssast).
Moreover, several machine learning explainability techniques are used to show what the model is examining for its prediction task.
Using a small data set of 1900 samples, we were able to train the novel model and achieve state of the art performance, reaching a median error over a 134 samples, unseen test set, of 0.79, which falls within the manual labeling process's noise levels.
Our light-weight Echolocation Audio Spectrogram Transformer is as far as we know the first of its kind, solving the task of bat Doppler shift compensation using deep learning methods and specifically transformers.
