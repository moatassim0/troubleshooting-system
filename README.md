1. Introduction and Objectives

1.1 Project Overview

This study reports upon an implemented car troubleshooting expert system created in Prolog, working to provide car owners with automated diagnostic analysis of general vehicle issues based on reported symptoms. The expert system utilizes artificial intelligence principles including backward chaining inference and rule-based reasoning to generate recommended recommendations.

1.2 Project Objectives

There are three main objectives of this expert system. Firstly, it aims to provide users with certain level of automotive diagnostic aid without any assumption of prior technical knowledge such that users can have some idea about what may be wrong with their cars even before approaching professional mechanics. The second objective of this expert system is to serve as hands-on example of basic concepts such as knowledge representation via predicate logic, backward-chaining inference, and confidence reasoning. The third objective of this expert system relates to awareness of ethical considerations in developing AI systems and its role in employing disclaimers to ensure users realize limits of automated automotive diagnostic systems.

1.3 Scope and Domain

The expert system encompasses six major expertise areas in the automobile business, battery and electrical systems, fuel delivery systems, starter systems, cooling systems, brake systems, engine performance issues, transmission issues, and exhaust systems. The knowledge base contains twenty-six separate faulty types with associated symptom patterns and recommended corrective actions. The system recognizes and processes fifty-eight total distinct symptoms that users may observe about their vehicle.

3. Knowledge Representation Design

2.1 Knowledge Base Structure

The knowledge base employs a formal predicate representation scheme. The scheme recognizes three types of knowledge: fault definitions, symptoms, and dynamic responses from users. The knowledge representation helps to ensure modularity in reasoning.
The main knowledge representation scheme will be fault predicate and will require three arguments. The first argument would be the kind of fault described by a special atom such as dead_battery or worn_brake_pads. The second would be a list of symptoms related to this kind of fault type so pattern matching can be performed for diagnosis. The third would be a string stating what must be done about it to guide the person who carries out diagnosis.

For example, dead_battery would be represented as follows: fault(dead_battery, [engine_not_starting, no_electrical_power, dim_headlights, clicking_sound_when_starting], 'Recharge or replace the battery. Check battery terminals for corrosion.'). This representation captures the diagnostic rule that if a vehicle shows the symptoms listed, then it is likely caused by a dead battery, and the provided action should be taken.

2.2 Symptom Descriptions

For every symptom in this system, there exists a description written in human language; these are all stored inside the knowledge management part involving the symptom description predicate. The above implementation makes it clear where the symbolic representation differs from the natural language representation utilized by human users to aid in maintaining codes. It would be easier to have internationalized representations if needed. The example symptom engine_not_starting "Engine does not start when you turn the key”.

2.3 Dynamic Predicates

The system utilizes three dynamic predicates that are asserted and retracted at runtime to hold the session state. The symptom_present predicate is for symptoms that users will confirm are present in their vehicle. The symptom_absent predicate specifies the symptoms that users actively assert are not present in their vehicle, although this information is currently only used for completeness and not in the inference process. The diagnosed predicate is an assertable predicate that the system keeps for future potential development in which diagnostics would be done over multiple sessions and could be compared.  
This dynamic process allows the system to maintain the conversational state through any diagnostic session and maintain a clean slate at the start of a new session with the clear_session predicate.

2.4 Symptom Categorization

To aid structured questioning and improve the user experience, symptoms are organized into logical categories for questioning by means of the category_symptoms predicate. The original seven categories are as follows: starting symptoms, engine symptoms, brake symptoms, cooling symptoms, electrical symptoms, transmission symptoms, and warning light symptoms. Categorizing symptoms has two functions, broadly speaking. First, it organizes the comprehensive diagnosis workflow from symptom to possible diagnosis in an appropriate order. In addition, it allows for targeted quick diagnosis modes that do not require the user to go through the whole routine and focus on the area/s of their concern.

3. Inference Mechanism

3.1 Backward Chaining Approach

The system employs backward chaining inference, which is Prolog's idiomatic reasoning approach. Specifically, rather than forward chaining from symptoms to conclusions, the system adopts a hypothesis to accommodate the possible fault and then checks whether enough corroborating symptoms are present. Backward chaining inference is very computationally efficient and is also intuitive with the reasoning of diagnostic experts. Diagnostic experts both medical and mechanical usually think of potential diagnoses and then check for supporting evidence.

3.2 Fault Detection Logic

The has_fault predicate embodies the fundamental inference mechanism, which assembles enough evidence to diagnose a fault. Initially, the predicate will retrieve the list of symptoms that are associated with a fault. The predicate then uses the count_matching_symptom helper predicate to determine how many of the associated symptoms have been confirmed by the user.
The system also includes a confidence threshold to avoid false positives. To diagnose a fault, at least fifty percent of the symptoms must be confirmed, or two symptoms must match, whichever is greater. This dual threshold allows for confirmation of multiple symptoms for faults with only two or three symptoms but requires proportional confirmation for faults that have many associated symptoms. For example, a fault with eight symptoms will require four symptoms to be confirmed before diagnosing the fault, while a fault with just two symptoms would require confirmation of both symptoms.

3.3 Confidence Calculation

In addition to binary diagnosis, the system assesses a confidence level for each diagnosed fault using the confidence level predicate. Confidence is computed as the percentage of required symptoms present, as an integer value from zero to one hundred. This percentage provides a sense to the user of how confident the diagnosis is in each case.
For example, if a fault has five symptoms associated with it and the user can confirm that four are present, then the confidence level is 0.80. This is useful for users in prioritizing faults, and for understanding how strong the evidence is for the diagnosis.

3.4 Multiple Diagnosis Handling

The system acknowledges that automotive issues are frequently characterized by several faults present concurrently and the get_diagnosed_faults predicate will capture any faults that met the diagnostic threshold, and sorts and presents combined faults in output order by confidence from the highest degree of certainty to the lowest. This ordering of faults in effect gives the user a preferred plan of action rather than an unordered list of faults that may all be possibilities. The order is achieved by the built-in sort predicate in Prolog, and the order of listing faults is written to use @> or @>= function in Prolog to compare the confidence predicate in the list of faults. This process ensures the interpretation of the fault will come from however many faults are assembled because they are more likely than another assembly of faults.

3.5 Reasoning Process Example

To illustrate how the inference engine works, we will assume that the symptoms entered by the user are engine_not_starting, no_electrical_power, and dim_headlights. The engine will then search all of the faults that have been established in the knowledge base. For dead battery fault, it needs symptoms engine_not_starting, no_electrical_power, dim_headlights, and clicking_sound_when_starting. In this case, assuming it meets three out of four symptoms needed for this fault, it will provide a certainty of seventy-five percent. For corroded battery terminals fault, it needs symptoms engine_not_starting, dim_headlights, and electrical_flickering. In this case, assuming it meets two out of three symptoms needed for this fault, it will provide a certainty of sixty-seven percent. Both meet the diagnosis level and would be presented to the user; first would be dead battery fault because it had greater certainty.

5. Sample Runs and System Demonstration

4.1 System Startup and Main Menu

When the user first launches the system invoking the start predicate, they will see the header "CAR TROUBLESHOOTING EXPERT SYSTEM" formatted using ASCII box-drawing characters. Immediately below this it outlines the Disclaimer which states that the system is providing advice only and is not a substitute for an actual inspection of the vehicle by a licensed mechanic. In particular, the Disclaimer cautions users regarding critical safety systems, warns users to take the vehicle to a licensed mechanics, and has a liability statement. 

<img width="384" height="452" alt="image" src="https://github.com/user-attachments/assets/289e5f3c-e4a6-49fd-86f8-de31661f2d9c" />

Once the user has accepted the terms of the Disclaimer they are shown the main menu with five user options: to perform a new comprehensive diagnosis, to perform a quick diagnosis which are for the common problems, to see what faults are captured within the knowledge base of the system, to learn more about the system, and leave the application. The menu provides flexibility with the user capabilities and needs and accommodates for users with different experience levels.

<img width="434" height="466" alt="image" src="https://github.com/user-attachments/assets/9c799038-1296-457a-9328-73093197e4ed" />


4.2 Comprehensive Diagnosis Workflow

Upon selection of the comprehensive diagnosis, a structured interview begins, organized by categories of symptoms. Each symptom category begins with engine starting issues. Sample questions prompt users to indicate whether, for example, the engine does not start, there is no electrical power, the headlights are dim, or a clicking sound occurs when attempting to start the vehicle. Responses used are either yes, no, I will skip to the next question, or I am done if the participant is finished questionnaire early. 

<img width="834" height="395" alt="image" src="https://github.com/user-attachments/assets/38158dbc-dd30-431d-8367-119641c3cfc0" />

The system offers immediate feedback when users indicate there is a data point, with checkmarks to log the assigned values, for example when the user selected "Engine does not start when you turn the key" the system shows "✓ Noted: engine_not_starting" before the next question prompt. The participant can see their input has been captured and marks a form of responsiveness to the user.

<img width="831" height="150" alt="image" src="https://github.com/user-attachments/assets/b0927479-cb95-474b-b386-5ada991ad607" />

The interview is completed; all seven categories, unless the user taps skip categories or finished early. This system incorporates a comprehensive approach to data collection, but respects user's time and patience for completing these types of questionnaires through the skip or done options.

4.3 Quick Diagnosis Mode

The rapid diagnostic mode serves as an expeditious alternative for individuals who have identified a general problem area. When selecting this mode, the user is presented with six common problem areas: car will not start, engine overheating, brake problems, strange noises, warning lights on dashboard, and poor performance and fuel economy. After selecting a problem area, users are presented with a focused set of interview questions based on the problem area they selected.

<img width="520" height="538" alt="image" src="https://github.com/user-attachments/assets/bfd5b461-9f14-4dcc-bd9b-a9fddebaf281" />

As an example, when a user selects the overheating option, the diagnostic mode asks questions related to the following: temperature warning light, coolant puddles, any visible leaks, low coolant, any temperature fluctuations, heater working, and strange noises. Targeting questions in this manner minimizes interview time while allowing the best level of diagnostic accuracy for a narrow problem area.

<img width="513" height="516" alt="image" src="https://github.com/user-attachments/assets/b339fd55-f447-45de-abc4-0adce2c471b8" />

4.4 Diagnosis Results Presentation

Upon completion of symptom reporting the system returns comprehensive results which begins with a summary of reported symptoms. This summary is an opportunity to confirm to users that their responses were interpreted correctly and provide rationale for the presented diagnosis. Each symptom is then displayed with human readable text for the symptom followed by a bullet point for clarity.
The system then returns diagnosed faults in descending order of confidence level. Faults are presented in a formatted block where the fault name replaces underscores with spaces followed by the confidence percentage and recommended action. For example, a fault of dead battery would return a confidence of ninety percent and then the assumed recommendation: "Recharge or replace the battery. Check battery terminals for corrosion."
If there is more than one fault returned, fault information is separated into different blocks and sorted by confidence to assist users in deciding how to troubleshoot their issue, in what order. For example, if there was another fault that had an eighty percent confidence level that is also a valid diagnosis. If the system did not meet the threshold of confidence for any specific fault, the system states no fault can be made and provides the user possible rationale for that. For example, insufficient symptoms were reported, the problems were outside the knowledge base, or the problems were rare and complex and necessitate professional diagnosis.

<img width="939" height="1081" alt="image" src="https://github.com/user-attachments/assets/3c312934-7185-466a-b60f-1171af1a5a57" />

4.5 View All Faults Feature

The "View All Faults" option facilitates learning about the system's knowledge base. The feature lists each fault that the system can identify noting the fault's name, the number of symptoms associated with the fault, and the recommended action that should be taken. For example, it might state the following, "Worn brake pads, (3 symptoms) - Recommendation: Replace brake pads immediately. Check rotors for damage." This transparency allows the user to understand what the system can identify and not identify, potentially even revealing problems they had not recognized.

<img width="940" height="1070" alt="image" src="https://github.com/user-attachments/assets/a4651dad-5cba-4fa3-be75-a97c01f8b065" />

5. Ethical Considerations

5.1 Disclaimer Implementation

The system includes several layers of ethical protection in the form of lengthy disclaimers. When a user launches the system for the first time, they will see a disclaimer prominently formatted, which is displayed before any diagnostic capability becomes available. The disclaimer explains that the system provides guidance only and cannot take the place of professional mechanical inspection and diagnosis. Importantly, the disclaimer encourages users to consult a certified mechanic, if a serious issue is suspected, or steeing issues ornament the text explains if the user has ongoing brake or steering issues as well as identifying potential issues that may not be captured by the system. It explicitly describes the tool as a starting point, rather than evidence of a diagnosis. Finally, the disclaimer includes a statement, indicating the creators do not accept liability for any action taken based on utilizing the system to assess one's vehicle, even if that action is to do nothing at all. The initial disclaimer also has a prompt that requires the user to acknowledge receipt of the information before using the system; therefore, the user has acknowledged the decision and the limitations of the system recognition that they are making an independent decision, instead of passively scrolling through disclaimers. The disclaimer also appears again in slightly modified verbiage after the users receives a diagnosis result, listing the limitations of the system at the critical decision-making moment, when the user may hastily act on the results without checking with a professional first.

5.2 Limitations and Transparency

The design of the system recognises its limitations all along. In situations where it is not possible to make any kind of diagnosis, it provides explanations for likely reasons instead of results like “no data available”. The “view all faults” button ensures complete transparency about what can and cannot be diagnosed by these diagnosis tools. In situations where things go beyond what can be diagnosed in rules, it highlights such conditions explicitly.
The percentage confidence level for each diagnosis has a definite ethical application. The application of confidence level helps to ensure that users do not attribute equal credibility to borderline and strong results. When presented with a diagnosis based on a confidence level of fifty percent, it is understood that there isn't strong evidence. In such cases, professional judgment must be exercised.

<img width="734" height="214" alt="image" src="https://github.com/user-attachments/assets/db4fbbe3-04ec-47d1-8235-889c99361b28" />

6. Conclusion

6.1 Project Achievements

The System successfully validates the application of principles of Artificial Intelligence to real-world issues related to car diagnosis and repair. it satisfies the main objective of making car diagnostic services widely available via its organized knowledge domain comprising twenty-six types of ailments and fifty-eight symptoms. The Backwards Chaining Inference Technique helps to apply confidence-level reasoning to serve clients.

6.2 Final Remarks

The car troubleshooting expert system discussed above can be seen as a very successful combination of theory and application from the field of artificial intelligence. The development of this project not only shows how theory from AI can be applied but also shows how it can be done in such a way as to complement human decisions.






