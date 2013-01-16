<div class="content" markdown="1">

## <a name="research"></a>Research Interests

Generally, my interests lie in the area of [data analysis](http://en.wikipedia.org/wiki/Data_analysis); using mathematical, statistical and computational techniques to learn as much as possible from a given set of data.
[Neuroscience](http://en.wikipedia.org/wiki/Neuroscience), an exciting frontier of modern science, is an ideal area to explore these interests, and provides the opportunity to provide new understanding to the fundamental problem of how our brains work.
Experimental advances in modern neuroscience provide a rich source of data sets, which can often be large (or worse, small!), noisy and difficult to collect.
This provides a great challenge to support the work of my experimental colleagues by extracting the maximum value from the data they obtain. 

Specifically my work to date has primarily consisted of applying tools from [information theory](http://en.wikipedia.org/wiki/Information_theory) to the problem of neural coding; that is how neurons represent information about the outside world.
Information theory has a number of advantages for this; it is a measure of dependence between variables that is sensitive to both linear and non-linear effects, is non-parametric, placing no assumptions on the underlying system of study and provides quantitative results on a scale that can be meaningfully compared between different systems.
It can be used to evaluate the timing precision of spikes, evaluate different candidate codes (for example spike rate vs temporal spike pattern; population pooled spike count vs labelled line population code), as well as to quantify the different effects of interactions between variables in a system with multivariate input or output (for example, interactions between spiking neurons). 

Technically, I am interested in practical techniques for improving calculation or estimation of information theoretic quantities both in terms of improving statistical properties, for example by correcting for the [limited sampling bias](http://www.scholarpedia.org/article/Sampling_bias) and in terms of improving computational performance, which is important since many analyses require [Monte Carlo](http://en.wikipedia.org/wiki/Monte_Carlo_method) style controls which involve repeating information calculations many times on shuffled or modelled data and can be a significant bottleneck.
I am also interested in using numerical optimisation techniques to maximise information theoretic measures such as [entropy](http://en.wikipedia.org/wiki/Entropy_(information_theory) and [mutual information](http://en.wikipedia.org/wiki/Mutual_information).
I believe the properties of these quantities as intuitively appealing measures of uncertainty and dependence respectively suggest their value as objective functions for optimising models or other types of analysis. 
This approach as already been used successfully as a way to map neuronal receptive fields with correlated natural stimuli [(Sharpee et al. 2002)](http://arxiv.org/abs/physics/0212110v2), is a foundation of the ID3 and C4.5 algorithms for fitting decision trees, and has been used to fit hidden Markov model predictors for discrete random sequences [(Shalizi & Shalizi, 2004)](http://arxiv.org/abs/cs.LG/0406011).
During my PhD I developed an algorithm for investigating interactions of different orders in a system by efficiently finding probability distributions that maximize entropy subject to marginal constraints (included in [pyEntropy](/code.html#pyentropy)) and I am keen to explore this approach of applying brute force optimisation to information theoretical objectives more in the future.

I am also interested in applying techniques from [machine learning](http://en.wikipedia.org/wiki/Machine_learning) to these large scale problems of neurological data analysis in general, and in particular the issue of neural coding.
For example, applying supervised learning algorithms to neural data can give insights into the performance of different codes even for response spaces and numbers of trials for which it would be impossible to directly calculate the mutual information.
I am interested in the relationship between decoding and information [(Quian Quiroga & Panzeri, 2010)](http://www.nature.com/nrn/journal/v10/n3/full/nrn2578.html), which means these supervised learning approaches can be used to give rigorous quantification of information transfer in large systems. 
I am also looking at other dimensionality reduction methods (self-organising maps, PCA) for calculating approximations to mutual information in high dimensional spaces. 
I believe this is an important area of research, since the curse of dimensionality means current methods for direct information estimation can never be extended to large neural populations - the amount of data required would take more than a lifetime to collect.
Although these techniques will always be an approximation, if they can be properly understood they can provide more useful tools to investigate how information is represented and processed in large groups of neurons.


## <a name="projects"></a>Current Projects


### <a name="proj_info"></a>Information theoretic analysis tools

A major difficulty when estimating information theoretic quantities from experimental data is the problem of *bias*, a systematic error caused by limited sampling. 
While many techniques have been developed to correct for this effect, implementing them can be an involved task. 
I have developed [pyEntropy](http://code.google.com/p/pyentropy), an open source Python library which implements a range of bias corrections.
Having these tools freely available is important to encourage wider use of the techniques, and easily allow people to try a range of corrections or measures on their data (or on simulated data with similar statistical properties). 
Additionally, this library implements the information breakdown technique [(Pola et al. 2003)](http://dx.doi.org/10.1088/0954-898X/14/1/303) which quantifies the effect of different types of interaction between the multivariate outputs (or inputs) of a system, as well as a tool for computing maximum entropy solutions subject to marginal equality constraints which can be used to obtain further details of the effect of interactions of different orders.

I am currently working on the statistical interpretation of mutual information as a test of independence, characterising the distribution under the null hypothesis and investigating the effects of temporal dependence in signals. I am also looking at applications of conditional mutual information in neural data analysis, for example when dealing with correlated stimuli, or to provide a form of robust group inference.

### <a name="proj_te"></a>Information transfer in MEG data

Finding an accurate and reliable way to quantify the flow of information transfer during a cognitive task would provide a great methodological advance, allowing experimenters to trace the flow of information, reconstruct information processing networks and hence gain insight into the neural mechanisms underlying behaviour. The spatio-temporal properties of the [MEG signal](http://en.wikipedia.org/wiki/Magnetoencephalography) make it the ideal modality with which to address these sorts of questions. We are investigating the best way to apply techniques such as transfer entropy to such data, both in terms of optimising statistical properties as well as developing efficient implementations.

### <a name="proj_fmri"></a>Information theoretic analysis of fMRI data

There are two fundamental approaches to the statistical detection of activated regions in fMRI imaging experiments; by using external stimulus information to find regions where activity correlates with stimulus changes (e.g. the General Linear Model [GLM]), or by purely data driven approaches which attempt to extract commonly activated areas from the data without any external information (e.g. Independent Component Analysis [ICA]). 
I am developing information theoretic techniques for both of these approaches.

In the first case, one can view mutual information between a stimulus condition and the [BOLD response](http://en.wikipedia.org/wiki/Functional_magnetic_resonance_imaging) as the effect size for a statistical test of independence. 
If there is a significant deviation from independence, then the response is modulated by the stimulus and hence that region can be considered activated during the task. 
In some ways this is more general than traditional statistical comparisons such as the t-test; for example if the mean of the response did not change, but the variance did, mutual information would be sensitive to such an effect.
[P-values](http://en.wikipedia.org/wiki/P-value) can be obtained directly from the information value, which allows direct comparison with results from other methods, such as the [GLM](http://en.wikipedia.org/wiki/Statistical_parametric_mapping).
The advantage is that no assumptions are made about the response (for example normality), the mechanism of activation (no requirement for a [HRF](http://en.wikipedia.org/wiki/Haemodynamic_response) to be specified) or the linearity of the effect.
A disadvantage is that if responses to different conditions overlap in time it is difficult to tease out the effect of the different conditions (the beauty of the GLM approach is that it allows such separation).
I am currently working to develop the best way to apply these techniques to different block or event related designs, how to account for temporal dependence in the statistical inference and how the information approach can be extended to group analysis as well as producing high performance code to implement the analysis.

To address the second case, where stimulus information is not available, I am investigating graph-theoretic clustering methods together with information based dependency measures between individual voxels to obtain, in a purely data-driven way, areas that are activated together. 

### <a name="proj_decoding"></a>Quantitative investigation of large population codes

The sensory coding properties of single cells have been well studied, using for example techniques of mutual information. 
However, applying these techniques to larger populations of more than 50 neurons is impossible.
I am using supervised learning algorithms to investigate the sensory coding properties of large populations of cells in auditory cortex. 


<p></p>
<hr class="half" />
<p></p>
<p></p>

<div class="textcenter" markdown="1">
<a name="pubs"></a>
<a href="http://scholar.google.com/citations?user=tI7ZazkAAAAJ"><img src="img/scholar_logo_md_2011.gif" alt="Google Scholar Citations" title="Google Scholar Citations" /></a> 
</div>

## Publications

<div id="bib" markdown="1">

### <a name="2012"></a>2012

* <a name="ince2012chap"></a>RAA Ince  
  **Open-source software for studying neural codes**  
  in S Panzeri and R Quian Quiroga (Eds) *Principles of Neural Coding*, CRC Press (in press)  
  \[ [LINK (amazon)](http://www.amazon.com/Principles-Neural-Coding-Rodrigo-Quiroga/dp/1439853304) \] 
* <a name="kayser2012slow"></a>C Kayser, RAA Ince and S Panzeri  
  **Analysis of slow (theta) oscillations as a potential temporal reference frame for information coding in sensory cortex**  
  *PLoS Computational Biology* (2012) <b>8</b>(10) e1002717  
  \[ [LINK (Open Access)](http://dx.doi.org/10.1371/journal.pcbi.1002717) \]
* <a name="ince2012ant"></a> RAA Ince\*, A Mazzoni\*, A Bartels, NK Logothetis and S Panzeri  
	**A novel test to determine the significance of neural selectivity to single and multiple potentially correlated features**  
  *Journal of Neuroscience Methods* (2012) <b>210</b>:1 p. 49-65  
  \[ [LINK (Subscription Required)](http://dx.doi.org/10.1016/j.jneumeth.2011.11.013) | [PDF](/papers/Ince2011_JNM_inpress.pdf) \]


### <a name="2011"></a>2011

* <a name="panzeri2011ita"></a> S Panzeri and RAA Ince (2011)  
	**Information theoretic approaches to the analysis of neural population recordings**  
	in N Kriegeskorte and G Kreiman (Eds)  *Visual population codes: toward a common multivariate framework for cell recording and functional imaging*, MIT Press  
  \[ [LINK (amazon)](http://www.amazon.com/Visual-Population-Codes-Multivariate-Computational/dp/0262016249) \]

### <a name="2010"></a>2010
* <a name="ince2010itm"></a> RAA Ince, R Senatore, E Arabzadeh, F Montani, ME Diamond and S Panzeri  
	**Information theoretic methods for studying population codes**  
	*Neural Networks* (2010) <b>23</b>:6 p. 713-727  
	\[ [LINK (Subscription Required)](http://dx.doi.org/10.1016/j.neunet.2010.05.008) | [PDF](/papers/Ince2010_NeuralNetworks_preprint.pdf) \]
* <a name="ince2009ost"></a>
	RAA Ince, A Mazzoni, R Petersen and S Panzeri  
	**Open source tools for the information theoretic analysis of neural data**  
	*Frontiers in Neuroscience* (2010) <b>4</b>:1 p. 62-70  
	\[ [LINK (Open Access)](http://frontiersin.org/neuroscience/neuroscience/paper/10.3389/neuro.01/011.2010/) \]

### <a name="2009"></a>2009
* <a name="ince2009otp"></a>
  RAA Ince, F Montani, E Arabzadeh, ME Diamond and S Panzeri  
  **On the presence of high-order interactions in somatosensory cortex and their effect on information transmission**  
	*Journal of Physics: Conference Series* (2009) <b>197</b> 012013 (1pp)  
	\[ [LINK (Open Access)](http://stacks.iop.org/1742-6596/197/012013) \]
* <a name="ince2009ait"></a>
  RAA Ince, C Bartolozzi and S Panzeri  
  **An information theoretic library for analysis of neural codes**  
	*The Neuromorphic Engineer* (2009) doi: 10.2417/1200906.1663  
	\[ [LINK (Open Access)](http://www.ine-news.org/view.php?source=1663-2009-06-17) \]
* <a name="montani2009tih"></a>
  F Montani\*, RAA Ince\*, R Senatore, E Arabzadeh, ME Diamond and S Panzeri  
  **The impact of high-order interactions on the rate of synchronous discharge and information transmission in somatosensory cortex**  
	*Philosophical Transactions of the Royal Society A* (2009) <b>367</b>:1901 p. 3297-3310  
	\[ [LINK (Subscription Required)](http://rsta.royalsocietypublishing.org/content/367/1901/3297.short) | [PDF](/papers/Montani2009_preprint.pdf) \] 
* <a name="ince2009pfi"></a>
  RAA Ince, RS Petersen, DC Swan and S Panzeri  
  **Python for information theoretic analysis of neural data**  
  *Frontiers in Neuroinformatics* (2009) <b>3</b>:4.  
  \[ [LINK (Open Access)](http://www.frontiersin.org/neuroinformatics/paper/10.3389/neuro.11/004.2009/) \]

</div>
\* - These authors contributed equally to this work.

</div>

<div id="subcontent" markdown="1">
<div class="menublock" markdown="1">
- [Top](#)
- [Research Interests](#research)
- [Current Projects](#projects)
  + [Info Tools](#proj_info)
  + [Info Transfer](#proj_te)
  + [fMRI](#proj_fmri)
  + [Pop Coding](#proj_decoding)
- [Publications](#pubs)
  + [2012](#2012)
  + [2011](#2011)
  + [2010](#2010)
  + [2009](#2009)
</div>
</div>

<!-- vim: set ts=2 sw=2 ft=mkd :-->
