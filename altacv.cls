%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.7.1, 25 Aug 2023) written by
% LianTze Lim (liantze@gmail.com).
% This is also a fork (v1.7.1b, 11 Jan 2024) written by
% Nicolás Omar González Passerino (nicolas.passerino@gmail.com)
%
% Persian/Arabic RTL revision and visual redesign (11 Oct 2026) by
% Codex (OpenAI).
% Includes RTL layout, Persian/Arabic typography, and the Khayyam CV design.
%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%%
% Contributions:
% - https://github.com/liantze/AltaCV Original template
% - https://github.com/akreuzer Added ragged2e option (5 Nov 2018)
% - https://github.com/stefanogermano Fixed bad boxes and undefined font shape (July 2018)
% - https://github.com/foohyfooh Fixed blank spaces in \cvevent and bad link in README.md (June 2018)
% - https://github.com/logological Remove redundant hyperref and typos (Apr 2021)

%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2026/10/11 AltaCV v1.7.1b, Persian/Arabic RTL edition redesigned by Codex (OpenAI).]

%% v1.1: Optionally load academicons
%% v1.4: Nope, academicons is unnecessary; fontawesome5 has \faOrcid.
\DeclareOption{academicons}{\ClassWarning{altacv}{academicons option is now obsolete and unnecessary.}}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
%% v1.3: load hyperref for clickable hyperlinks
\newif\if@withhyper
\DeclareOption{withhyper}{\@withhypertrue}
\newif\ifdarkmode
\DeclareOption{darkmode}{\darkmodetrue}
% RTL documents use XeLaTeX and load xepersian (or bidi) last in the preamble.
\newif\if@rtl
\DeclareOption{rtl}{\@rtltrue}
\ProcessOptions\relax

\LoadClass{extarticle}
%% v1.3.2 Hopefully this helps make the PDF
%% file more 'friendly' with copy-paste etc
\RequirePackage{etoolbox}
\RequirePackage{ifxetex,ifluatex}
\if@rtl
  \ifxetex\else
    \ClassError{altacv}{The rtl option requires XeLaTeX}{Compile with xelatex instead of pdflatex or lualatex.}
  \fi
  % Ordinary Unicode PDF output; PDF/A needs a separate metadata setup.
  \RequirePackage[unicode]{hyperref}
\else
  \RequirePackage[a-1b]{pdfx}
\fi
\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{scrlfile}
\RequirePackage{xparse}

%% v1.1.5: added for convenience
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
\else
  %% v1.3.2 attempts to make ligatures
  %% copy-paste as normal characters
  \RequirePackage{cmap}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \input{glyphtounicode}
  \pdfglyphtounicode{f_f}{FB00}
  \pdfglyphtounicode{f_f_i}{FB03}
  \pdfglyphtounicode{f_f_l}{FB04}
  \pdfglyphtounicode{f_i}{FB01}
  \pdfgentounicode=1
\fi

\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

% Keep layout direction independent of Latin links and numbers.
\DeclareRobustCommand{\cvlatin}[1]{%
  \if@rtl\ifcsdef{lr}{\lr{#1}}{\LR{\ifcsdef{latinfont}{\latinfont}{}#1}}\else#1\fi
}
\DeclareRobustCommand{\cvtextdir}[1]{%
  \if@rtl\ifcsdef{rl}{\rl{#1}}{\RL{#1}}\else#1\fi
}
\newcommand{\cvalign}{%
  \if@raggedtwoe
    \if@rtl\RaggedLeft\else\RaggedRight\fi
  \else
    \if@rtl\raggedleft\else\raggedright\fi
  \fi
}
% Keep the accessibility PDF operators in LTR order, even around RTL text.
\newcommand{\cvicon}[2]{%
  \cvlatin{\mbox{\BeginAccSupp{method=pdfstringdef,ActualText={#2}}%
    \textcolor{accent}{#1}\EndAccSupp{}}}%
}

\if@withhyper
  \AtBeginDocument{%
    \hypersetup{hidelinks}
    \urlstyle{same}
  }
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}
% Renamed or added v1.7
\newcommand{\cvItemMarker}{{\small\textbullet}}
\newcommand{\cvRatingMarker}{\faCircle}
\let\itemmarker\cvItemMarker      % for backward compatibility
\let\ratingmarker\cvRatingMarker  % for backward compatibility
\newcommand{\cvDateMarker}{\faCalendar[regular]}
\newcommand{\cvLocationMarker}{\faMapMarker}
\newcommand{\locationname}{Location}
\newcommand{\datename}{Date}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
\setlist[itemize]{label=\cvItemMarker}
\RequirePackage{graphicx}
\RequirePackage{trimclip}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

%% v1.3.1 \detokenize will break UTF-8 in pdflatex
%% Using alternative from https://tex.stackexchange.com/a/530911/226
\newcommand{\utffriendlydetokenize}[1]{%
\scantokens{%
  \catcode`\_=12%
%   \catcode`\^=12%
%   \catcode`\{=12%
%   \catcode`\}=12%
  \catcode`\&=12%
  \catcode`\$=12%
  \catcode`\#=12%
  \catcode`\~=12%
%   \catcode`\\=12%
  {#1}%
}%
}
%% v1.3: Incorporating hyperlinks
%% v1.3.1: using \unfriendlydetokenize to avoid breaking unicode
%% v1.6: Use accsupp so that when copying/pasting the icon from PDF to a text
%%       file, the icon name is pasted
%% v1.7: Some tweaks/corrections so that accsupp is for icons only
%% v1.7.1: Bugfix to support some symbol commands e.g. academicons commands 
\ExplSyntaxOn
% Starred fields keep their value LTR; unstarred fields follow the document.
\NewDocumentCommand{\printinfo}{s m m o}{%
  \mbox{\cvicon{#2}{}~%
    \IfBooleanTF{#1}{\cvlatin{\altacvInfoValue{#3}{#4}}}{\altacvInfoValue{#3}{#4}}}%
  \hspace{1.25em}\allowbreak
}
\NewDocumentCommand{\altacvInfoValue}{m m}{%
  \IfNoValueTF{#2}{\utffriendlydetokenize{#1}}{%
    \if@withhyper
      \href{#2}{\utffriendlydetokenize{#1}}%
    \else
      \utffriendlydetokenize{#1}%
    \fi
  }%
}


%% v1.3: Exploring convenient creation of fields
%% v1.6: Add starred mode to create \printinfo with full URL
\NewDocumentCommand{\NewInfoField}{s m m o}{%
  \IfBooleanF{#1}{
    \IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
  }
  \csdef{#2 symbol}{#3}%
  \IfBooleanTF{#1}
    { \csdef{#2}##1##2{%
        \if@withhyper
          \IfNoValueTF {##2}
            {\printinfo*{\csuse{#2 symbol}}{##1}}%
            {\printinfo*{\csuse{#2 symbol}}{##1}[##2]}%
        \else
          \printinfo*{\csuse{#2 symbol}}{##1}%
        \fi%
      }%
    }
    { \csdef{#2}##1{%
        \if@withhyper
          \IfNoValueTF {#4}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo*{\csuse{#2 symbol}}{##1}[\csuse{#2 hyperprefix}##1]}%
        \else
          \IfNoValueTF{#4}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo*{\csuse{#2 symbol}}{##1}}%
        \fi%
      }%
    }
}
\ExplSyntaxOff

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{email}{\faAt}[mailto:]
\NewInfoField{mailaddress}{\faEnvelope}
\NewInfoField{phone}{\faPhone}[tel:]
\NewInfoField{homepage}{\faGlobe}[https://]
\NewInfoField{twitter}{\faTwitter}[https://twitter.com/]
\NewInfoField{linkedin}{\faLinkedin}[https://linkedin.com/in/]
\NewInfoField{github}{\faGithub}[https://github.com/]
% v1.?? Use fontawesome5 for Orcid symbol
\NewInfoField{orcid}{\faOrcid}[https://orcid.org/]
\NewInfoField{location}{\cvLocationMarker}
% Fork (before v1.6.5a): New optional options added for dev.to, medium and npm accounts
\NewInfoField{dev}{\faDev}[https://dev.to/]
\NewInfoField{medium}{\faMedium}[https://medium.com/@]
\NewInfoField{npm}{\faNpm}[https://www.npmjs.com/~]

% v1.2: Support for multiple photos
\newlength{\altacv@photos@width}
\newlength{\altacv@photo@diam@left}
\newlength{\altacv@photo@diam@right}
\def\altacv@left@photos{}
\def\altacv@right@photos{}

\newcommand{\@makeaphoto}[2]{%
  \begin{minipage}{#1}%
    \if@normalphoto
      \includegraphics[width=\linewidth]{#2}
    \else
% Fork (before v1.6.5a): The photo image has modified to include a border around it, which color is aligned to document's theme
      \tikz\filldraw[color=headingrule, fill overzoom image={#2}, line width=1.6pt](0,0) circle[radius=\dimexpr0.5\linewidth-0.8pt\relax];
    \fi%
  \end{minipage}%
}

% The actual photo gap must match the width reserved by the header.
\newcommand{\altacv@add@photo@left}[1]{%
  \appto{\altacv@left@photos}{%
    \@makeaphoto{\altacv@photo@diam@left}{#1}\hspace{1ex}%
  }%
  \addtolength{\altacv@photos@width}{\altacv@photo@diam@left}%
  \addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\altacv@add@photo@right}[1]{%
  \appto{\altacv@right@photos}{%
    \hspace{1ex}\@makeaphoto{\altacv@photo@diam@right}{#1}%
  }%
  \addtolength{\altacv@photos@width}{\altacv@photo@diam@right}%
  \addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\photoL}[2]{%
  \setlength{\altacv@photo@diam@left}{#1}%
  \forcsvlist{\altacv@add@photo@left}{#2}%
}
\newcommand{\photoR}[2]{%
  \setlength{\altacv@photo@diam@right}{#1}%
  \forcsvlist{\altacv@add@photo@right}{#2}%
}
\let\photo\photoR

\newcommand{\namefont}{\Huge\bfseries}
\newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\footnotesize\bfseries}
\newcommand{\cvsectionfont}{\LARGE\bfseries}
\newcommand{\cvsubsectionfont}{\large\bfseries}
\newcommand{\cveventfont}{\large\bfseries}
\newcommand{\cvmetafont}{\small}
\newcommand{\cvtagfont}{\small}
\if@rtl
  \renewcommand{\namefont}{\fontsize{28}{36}\selectfont\bfseries}
  \renewcommand{\taglinefont}{\fontsize{12}{18}\selectfont\bfseries}
  \renewcommand{\personalinfofont}{\fontsize{10}{15}\selectfont}
  \renewcommand{\cvsectionfont}{\fontsize{17}{24}\selectfont\bfseries}
  \renewcommand{\cvsubsectionfont}{\fontsize{13}{19}\selectfont\bfseries}
  \renewcommand{\cveventfont}{\fontsize{13}{19}\selectfont\bfseries}
  \renewcommand{\cvmetafont}{\fontsize{10}{15}\selectfont}
  \renewcommand{\cvtagfont}{\fontsize{10.5}{16}\selectfont}
\fi

\newcommand{\makecvheader}{%
  \begingroup
    % PhotoL/PhotoR always refer to physical sides of the page.
    \if@rtl\begin{LTR}\fi
    \altacv@left@photos\hfill%
    \begin{minipage}{\dimexpr\linewidth-\altacv@photos@width}%
    \if@rtl\setRTL\fi
    \cvalign%
    {\namefont\color{name}\@name\par}
    \medskip
    {\taglinefont\color{tagline}\@tagline\par}
    \medskip
    {\personalinfofont\@personalinfo\par}
    \end{minipage}\hfill%
    \altacv@right@photos\par%
    \if@rtl\end{LTR}\fi
  \endgroup\medskip
}

\renewenvironment{quote}{\par\begingroup\color{accent}\if@rtl\normalsize\else\itshape\large\fi}{\par\endgroup}

% Fork v1.7.1a: cvsection skips adjusted for better space management
\newcommand{\cvsection}[2][]{%
  \par\addvspace{0.8\baselineskip}
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\cvalign\input{#1}}}%
  {\color{heading}\cvsectionfont\cvtextdir{#2}\par}\nobreak
  \vspace{0.2ex}
  {\color{headingrule}\hrule height 1.2pt}\nobreak
  \smallskip
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{subheading}\cvsubsectionfont{#1}\par}
  \medskip
}

% Fork v1.6.5b
\newcommand{\cvreference}[2]{
  \textcolor{accent}{\href{#2}{#1}}
}

% v1.7: adds accsupp ActualText for location and date markers
% Fork v1.7.1a: Structure adjusted with fork's styling
\newcommand{\cvevent}[4]{%
  \par{\cveventfont\color{emphasis}#1\par}\nobreak
  \ifstrequal{#2}{}{}{%
    {\color{accent}#2\par}\nobreak}%
  {\cvmetafont\color{emphasis}%
    \ifstrequal{#3}{}{}{\cvicon{\cvDateMarker}{\datename:}~#3}%
    \ifstrequal{#4}{}{}{%
      \ifstrequal{#3}{}{}{\hspace{1.5em}\allowbreak}%
      \cvicon{\cvLocationMarker}{\locationname:}~#4}%
    \par}%
  \smallskip
}

% v1.7: adds accsupp for the icon as well
\newcommand{\cvachievement}[3]{%
  \par\noindent
  \begin{minipage}[t]{2em}\vspace{0pt}\Large\cvicon{#1}{}\end{minipage}%
  \hspace{1ex}%
  \begin{minipage}[t]{\dimexpr\linewidth-2em-1ex\relax}
    \vspace{0pt}\cvalign
    {\bfseries\textcolor{emphasis}{#2}\par}
    #3\par
  \end{minipage}\par\smallskip
}

% Fork v1.6.5c: Added new tag list parser for several items that will reutilize the cvtag component in a less verbose way
% Fork v1.7.1b: Adjusted to new property in cvtag
\newcommand{\cvtags}[1]{%
  \leavevmode
  \foreach \value/\isHighlighted in {#1} {%
    \cvtag{\value}{\isHighlighted}\hspace{0.4em}\allowbreak
  }\par
}

% Fork (before v1.6.5a): Tags now have a more consistent vertican and horizontal separation
% Fork v1.7.1b: cvtag now includes a boolean flag to highlight its text and border among other of its type
\NewDocumentCommand{\cvtag}{m G{false}}{%
  \leavevmode
  \edef\altacv@tag@highlight{#2}%
  \ifdefstring{\altacv@tag@highlight}{true}{%
    \tikz[baseline]\node[anchor=base,draw=accent,rounded corners=2pt,inner xsep=0.8ex,inner ysep=0.45ex,font=\cvtagfont]{\cvtextdir{\markword{#1}}};%
  }{%
    \tikz[baseline]\node[anchor=base,draw=body!50,rounded corners=2pt,inner xsep=0.8ex,inner ysep=0.45ex,font=\cvtagfont]{\cvtextdir{#1}};%
  }
}

% v1.6: Use accsupp so that the actual numeric value is copied/pasted
%       and also support 0.5, 1.5, 2.5, 3.5, 4.5
\newcommand{\cvskill}[2]{%
  \begingroup
  \if@rtl\def\altacv@ratingorder{5,4,3,2,1}\else\def\altacv@ratingorder{1,2,3,4,5}\fi
  \textcolor{emphasis}{\textbf{#1}}\hfill
  \cvlatin{\BeginAccSupp{method=plain,ActualText={#2}}
  \foreach \x in \altacv@ratingorder{%
    \ifdimequal{\x pt - #2 pt}{0.5pt}%
    {\clipbox*{0pt -0.25ex {.5\width} {\totalheight}}{\if@rtl\color{body!30}\else\color{accent}\fi\cvRatingMarker}%
     \clipbox*{{.5\width} -0.25ex {\width} {\totalheight}}{\if@rtl\color{accent}\else\color{body!30}\fi\cvRatingMarker}}
    {\ifdimgreater{\x bp}{#2 bp}{\color{body!30}}{\color{accent}}\cvRatingMarker}%
  }\EndAccSupp{}}\par\endgroup%
}

% Fork (before v1.6.5a): Tag added for languages rating, avoiding star/button/progress bar previous ideas, I made a simpler and more accurate representation using a single string, which will be colored to be oustanding
\newcommand{\cvlang}[2]{%
    \textcolor{emphasis}{\textbf{#1: }}
    \textcolor{accent}{\textbf{#2}}
}

% Adapted from @Jake's answer at http://tex.stackexchange.com/a/82729/226
\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}

      % Rotate so we start from the top
      \begin{scope}[rotate=\totalrot]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            % v1.6: Use accsupp so that the numeric number is copied/pasted too
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\cvlatin{\BeginAccSupp{method=pdfstringdef,ActualText={\name: \value}}\cvtextdir{\name}\EndAccSupp{}}};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}

% Fork v1.6.5b: Taking from original version, I added some modifications related to optional Linkedin and mail links for each reference (both will be shown only if there is any value)
\newcommand{\cvref}[3]{%
  \par
  \textcolor{emphasis}{\textbf{#1}}\par
  \smallskip
  {\cvmetafont
    \ifstrequal{#2}{}{}{\printinfo*{\faLinkedin}{#2}[https://linkedin.com/in/#2]\par}%
    \ifstrequal{#3}{}{}{\printinfo*{\mailaddresssymbol}{#3}[mailto:#3]\par}%
  }
}

% Fork v1.7.1b: New command markword added as a shortcut to change word color to the one assigned as accent
\newcommand{\markword}[1]{
  \textcolor{accent}{#1}
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\cvalign}{\end{minipage}}

% v1.5 Move biblatex-related code to separate .cfg file
% so that it's easier to change and customise the style for
% publication lists

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

% v1.6.5 But provide for ability to highlight names in publication list
\RequirePackage{pgffor}
\def\my@namelist{}
\newcommand{\mynames}[1]{\def\my@namelist{#1}}
\newtoggle{boldname}
\AddToHook{package/biblatex/after}{
\renewcommand*{\mkbibnamefamily}[1]{%
  \global\togglefalse{boldname}%
  \foreach \my@fname / \my@gname in \my@namelist {%
    \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                 and
                 test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}}{}%
  }%
  \iftoggle{boldname}{\textbf{#1}}{#1}%
}

\renewcommand*{\mkbibnamegiven}[1]{%
  \global\togglefalse{boldname}%
  \foreach \my@fname / \my@gname in \my@namelist{%
    \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                 and
                 test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}\breakforeach}{}%
  }%
  \iftoggle{boldname}{\textbf{#1}}{#1}%
}
}

\AddToHook{begindocument/before}{%
  \if@rtl
    \@ifpackageloaded{bidi}{}{%
      \ClassError{altacv}{RTL needs xepersian or bidi}{Load xepersian (Persian) or bidi (Arabic) after all other packages.}%
    }%
  \fi
  \pagestyle{empty}
  \color{body}
  \cvalign
}
