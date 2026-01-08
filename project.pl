% ============================================================================
% Team Number 3
% Members: Members: Moatassim Arbaoui 202210663, Khalid Mohamed 202210406
% Course: INT430 - Artificial Intelligence
% Project: Car Troubleshooting Expert System


% ----------------------------------------------------------------------------
% SECTION 1: DYNAMIC PREDICATES
% These predicates store user responses during a diagnosis session.
% We declare them dynamic so they can be asserted/retracted at runtime.
% ----------------------------------------------------------------------------

:- dynamic symptom_present/1.    % Stores symptoms the user confirms
:- dynamic symptom_absent/1.     % Stores symptoms the user denies
:- dynamic diagnosed/1.          % Stores faults that have been diagnosed

% ----------------------------------------------------------------------------
% SECTION 2: KNOWLEDGE BASE - FAULT DEFINITIONS
% Each fault is defined with its associated symptoms and recommended actions.
% Format: fault(FaultName, SymptomList, RecommendedAction).
% ----------------------------------------------------------------------------

% Battery-related faults
fault(dead_battery, 
      [engine_not_starting, no_electrical_power, dim_headlights, clicking_sound_when_starting],
      'Recharge or replace the battery. Check battery terminals for corrosion.').

fault(corroded_battery_terminals,
      [engine_not_starting, dim_headlights, electrical_flickering],
      'Clean battery terminals with baking soda solution. Apply terminal protector.').

% Fuel system faults
fault(empty_fuel_tank,
      [engine_not_starting, fuel_gauge_low, engine_cranks_but_no_start],
      'Refill the fuel tank. If gauge malfunctioned, have it inspected.').

fault(clogged_fuel_filter,
      [engine_stalling, poor_acceleration, difficulty_starting, engine_sputtering],
      'Replace the fuel filter. Typically recommended every 20,000-40,000 miles.').

fault(faulty_fuel_pump,
      [engine_not_starting, engine_sputtering_at_high_speed, loss_of_power, whining_from_fuel_tank],
      'Have the fuel pump tested and replaced if necessary by a mechanic.').

% Starter system faults
fault(faulty_starter_motor,
      [engine_not_starting, clicking_sound_when_starting, grinding_noise_when_starting],
      'Have the starter motor tested. May need replacement or solenoid repair.').

fault(bad_ignition_switch,
      [engine_not_starting, no_response_when_turning_key, electrical_accessories_not_working],
      'Have the ignition switch inspected and replaced if faulty.').

% Cooling system faults
fault(low_coolant,
      [engine_overheating, temperature_warning_light, coolant_puddle_under_car],
      'Check and refill coolant. Inspect for leaks in hoses and radiator.').

fault(faulty_thermostat,
      [engine_overheating, temperature_fluctuations, heater_not_working_properly],
      'Replace the thermostat. It is an inexpensive but critical component.').

fault(radiator_leak,
      [engine_overheating, coolant_puddle_under_car, visible_coolant_leak, low_coolant_level],
      'Locate and repair the leak. May need radiator replacement if severe.').

fault(water_pump_failure,
      [engine_overheating, coolant_leak_front_of_engine, whining_noise_from_engine],
      'Replace the water pump immediately to prevent engine damage.').

% Brake system faults
fault(worn_brake_pads,
      [squealing_when_braking, grinding_when_braking, longer_stopping_distance],
      'Replace brake pads immediately. Check rotors for damage.').

fault(low_brake_fluid,
      [brake_warning_light, soft_brake_pedal, brakes_feel_spongy],
      'Check and refill brake fluid. Inspect system for leaks.').

fault(warped_brake_rotors,
      [vibration_when_braking, pulsating_brake_pedal, steering_wheel_shakes_when_braking],
      'Have rotors resurfaced or replaced. Check for caliper issues.').

fault(brake_fluid_leak,
      [brake_warning_light, soft_brake_pedal, fluid_puddle_under_car, brakes_feel_spongy],
      'URGENT: Do not drive. Have vehicle towed to mechanic immediately.').

% Engine faults
fault(spark_plug_failure,
      [engine_misfiring, poor_acceleration, rough_idle, increased_fuel_consumption],
      'Replace spark plugs. Check ignition coils and wires as well.').

fault(faulty_alternator,
      [battery_warning_light, dim_headlights, electrical_flickering, dead_battery_repeatedly],
      'Test and replace the alternator. It charges the battery while driving.').

fault(clogged_air_filter,
      [poor_acceleration, reduced_fuel_economy, engine_misfiring, black_smoke_from_exhaust],
      'Replace the air filter. Check every 12,000-15,000 miles.').

fault(timing_belt_worn,
      [ticking_noise_from_engine, engine_misfiring, engine_wont_turn_over, oil_leak_front_of_engine],
      'URGENT: Replace timing belt immediately to prevent catastrophic engine damage.').

% Transmission faults
fault(low_transmission_fluid,
      [transmission_slipping, delayed_gear_engagement, grinding_when_shifting],
      'Check and refill transmission fluid. Inspect for leaks.').

fault(transmission_problems,
      [transmission_slipping, grinding_when_shifting, burning_smell, check_engine_light],
      'Have transmission inspected by specialist. May need fluid change or repair.').

% Exhaust system faults
fault(catalytic_converter_failure,
      [check_engine_light, reduced_acceleration, sulfur_smell, failed_emissions_test],
      'Have catalytic converter inspected. Replacement may be necessary.').

fault(exhaust_leak,
      [loud_exhaust_noise, vibrations, decreased_fuel_efficiency, exhaust_smell_in_cabin],
      'Locate and repair exhaust leak. Check manifold gaskets and pipe connections.').

% Electrical faults
fault(blown_fuse,
      [specific_electrical_not_working, no_power_to_accessory],
      'Check fuse box and replace blown fuse with correct amperage.').

fault(faulty_sensors,
      [check_engine_light, poor_fuel_economy, rough_idle, failed_emissions_test],
      'Use OBD-II scanner to identify faulty sensor. Common: O2, MAF, or MAP sensor.').

% ----------------------------------------------------------------------------
% SECTION 3: SYMPTOM DESCRIPTIONS
% Human-readable descriptions for each symptom to display to the user.
% Format: symptom_description(SymptomID, Description).
% ----------------------------------------------------------------------------

symptom_description(engine_not_starting, 'Engine does not start when you turn the key').
symptom_description(no_electrical_power, 'No electrical power (dashboard lights, radio not working)').
symptom_description(dim_headlights, 'Headlights are dim or flickering').
symptom_description(clicking_sound_when_starting, 'Clicking sound when trying to start').
symptom_description(electrical_flickering, 'Electrical components flickering on and off').
symptom_description(fuel_gauge_low, 'Fuel gauge shows empty or very low').
symptom_description(engine_cranks_but_no_start, 'Engine cranks but does not start').
symptom_description(engine_stalling, 'Engine stalls unexpectedly while driving').
symptom_description(poor_acceleration, 'Poor acceleration or lack of power').
symptom_description(difficulty_starting, 'Difficulty starting the engine').
symptom_description(engine_sputtering, 'Engine sputters or hesitates').
symptom_description(engine_sputtering_at_high_speed, 'Engine sputters at high speeds').
symptom_description(loss_of_power, 'Sudden loss of engine power').
symptom_description(whining_from_fuel_tank, 'Whining noise coming from fuel tank area').
symptom_description(grinding_noise_when_starting, 'Grinding noise when starting the car').
symptom_description(no_response_when_turning_key, 'No response at all when turning the key').
symptom_description(electrical_accessories_not_working, 'Electrical accessories not working').
symptom_description(engine_overheating, 'Engine is overheating').
symptom_description(temperature_warning_light, 'Temperature warning light is on').
symptom_description(coolant_puddle_under_car, 'Puddle of coolant under the car').
symptom_description(temperature_fluctuations, 'Temperature gauge fluctuates abnormally').
symptom_description(heater_not_working_properly, 'Heater does not work properly').
symptom_description(visible_coolant_leak, 'Visible coolant leak in engine bay').
symptom_description(low_coolant_level, 'Coolant level is low').
symptom_description(coolant_leak_front_of_engine, 'Coolant leaking from front of engine').
symptom_description(whining_noise_from_engine, 'Whining noise from engine area').
symptom_description(squealing_when_braking, 'Squealing noise when braking').
symptom_description(grinding_when_braking, 'Grinding noise when braking').
symptom_description(longer_stopping_distance, 'Car takes longer to stop').
symptom_description(brake_warning_light, 'Brake warning light is on').
symptom_description(soft_brake_pedal, 'Brake pedal feels soft or spongy').
symptom_description(brakes_feel_spongy, 'Brakes feel spongy or unresponsive').
symptom_description(vibration_when_braking, 'Vibration felt when braking').
symptom_description(pulsating_brake_pedal, 'Brake pedal pulsates when pressed').
symptom_description(steering_wheel_shakes_when_braking, 'Steering wheel shakes when braking').
symptom_description(fluid_puddle_under_car, 'Fluid puddle under the car').
symptom_description(engine_misfiring, 'Engine misfires or runs rough').
symptom_description(rough_idle, 'Engine idles roughly').
symptom_description(increased_fuel_consumption, 'Increased fuel consumption').
symptom_description(battery_warning_light, 'Battery warning light is on').
symptom_description(dead_battery_repeatedly, 'Battery keeps dying repeatedly').
symptom_description(reduced_fuel_economy, 'Reduced fuel economy').
symptom_description(black_smoke_from_exhaust, 'Black smoke from exhaust').
symptom_description(ticking_noise_from_engine, 'Ticking noise from engine').
symptom_description(engine_wont_turn_over, 'Engine will not turn over at all').
symptom_description(oil_leak_front_of_engine, 'Oil leak at front of engine').
symptom_description(transmission_slipping, 'Transmission slipping between gears').
symptom_description(delayed_gear_engagement, 'Delayed response when shifting gears').
symptom_description(grinding_when_shifting, 'Grinding noise when shifting gears').
symptom_description(burning_smell, 'Burning smell from the car').
symptom_description(check_engine_light, 'Check engine light is on').
symptom_description(reduced_acceleration, 'Reduced acceleration response').
symptom_description(sulfur_smell, 'Sulfur or rotten egg smell').
symptom_description(failed_emissions_test, 'Failed emissions test').
symptom_description(loud_exhaust_noise, 'Unusually loud exhaust noise').
symptom_description(vibrations, 'Unusual vibrations while driving').
symptom_description(decreased_fuel_efficiency, 'Decreased fuel efficiency').
symptom_description(exhaust_smell_in_cabin, 'Exhaust smell inside the cabin').
symptom_description(specific_electrical_not_working, 'Specific electrical component not working').
symptom_description(no_power_to_accessory, 'No power to a specific accessory').

% ----------------------------------------------------------------------------
% SECTION 4: INFERENCE ENGINE
% Rules that determine if a fault is present based on symptoms.
% Uses backward chaining - Prolog's natural inference mechanism.
% ----------------------------------------------------------------------------

% has_fault/1 succeeds if enough symptoms for a fault are confirmed by user.
% We require at least 2 symptoms to match for a diagnosis (configurable).
has_fault(Fault) :-
    fault(Fault, RequiredSymptoms, _),
    count_matching_symptoms(RequiredSymptoms, Count),
    length(RequiredSymptoms, Total),
    % Require at least 50% of symptoms OR at least 2 symptoms
    MinRequired is max(2, Total // 2),
    Count >= MinRequired.

% Count how many symptoms from a list are present (confirmed by user)
count_matching_symptoms([], 0).
count_matching_symptoms([Symptom|Rest], Count) :-
    symptom_present(Symptom),
    !,
    count_matching_symptoms(Rest, RestCount),
    Count is RestCount + 1.
count_matching_symptoms([_|Rest], Count) :-
    count_matching_symptoms(Rest, Count).

% Calculate confidence level based on symptom match percentage
confidence_level(Fault, Confidence) :-
    fault(Fault, RequiredSymptoms, _),
    count_matching_symptoms(RequiredSymptoms, Count),
    length(RequiredSymptoms, Total),
    Confidence is (Count * 100) // Total.

% Get all possible faults sorted by confidence
get_diagnosed_faults(DiagnosedFaults) :-
    findall(conf(Conf, Fault), 
            (has_fault(Fault), confidence_level(Fault, Conf)), 
            UnsortedFaults),
    sort(0, @>=, UnsortedFaults, DiagnosedFaults).

% ----------------------------------------------------------------------------
% SECTION 5: USER INTERACTION SYSTEM
% Predicates for asking questions and collecting symptom information.
% ----------------------------------------------------------------------------

% Main entry point - starts the expert system
start :-
    clear_session,
    display_header,
    display_disclaimer,
    nl, write('Press Enter to continue...'), nl,
    read_line_to_string(user_input, _),
    main_menu.

% Display the welcome header
display_header :-
    nl,
    write('═══════════════════════════════'), nl,
    write('CAR TROUBLESHOOTING EXPERT SYSTEM'), nl,
	write('═══════════════════════════════'), nl.
    
% Display ethical disclaimer - REQUIRED for the project
display_disclaimer :-
    nl,
    write('─────────────────────────────────────────────'), nl,
    write('IMPORTANT DISCLAIMER'), nl,
    write('─────────────────────────────────────────────'), nl,
    write(' This expert system provides GUIDANCE ONLY and does NOT replace '), nl,
    write(' professional mechanical inspection and diagnosis.              '), nl,
    write('                                                                '), nl,
    write(' • Always consult a certified mechanic for serious issues       '), nl,
    write(' • Do not drive if you suspect brake or steering failure        '), nl,
    write(' • This system may not identify all possible problems           '), nl,
    write(' • Use this tool as a starting point, not a final diagnosis     '), nl,
    write('                                                                '), nl,
    write(' The creators assume no liability for decisions made based      '), nl,
    write(' on this system\'s recommendations.                             '), nl,
	write('─────────────────────────────────────────────'), nl.
    
% Main menu options
main_menu :-
    nl,
    write('═════════'), nl,
    write('MAIN MENU'), nl,
    write('═════════'), nl,
    write('  1. Start New Diagnosis'), nl,
    write('  2. Quick Diagnosis (Common Problems)'), nl,
    write('  3. View All Known Faults'), nl,
    write('  4. About This System'), nl,
    write('  5. Exit'), nl,
    write('Enter your choice (1-5): '),
    read_line_to_string(user_input, Choice),
    process_menu_choice(Choice).

% Process menu selections
process_menu_choice("1") :- !, clear_session, start_diagnosis.
process_menu_choice("2") :- !, clear_session, quick_diagnosis.
process_menu_choice("3") :- !, view_all_faults, main_menu.
process_menu_choice("4") :- !, display_about, main_menu.
process_menu_choice("5") :- !, 
    nl, write('Thank you for using the Car Troubleshooting Expert System.'), nl,
    write('Remember: Always consult a professional mechanic for serious issues!'), nl, nl.
process_menu_choice(_) :- 
    write('Invalid choice. Please enter a number between 1 and 5.'), nl,
    main_menu.

% ----------------------------------------------------------------------------
% SECTION 6: DIAGNOSIS PROCESS
% Systematic questioning to gather symptoms from the user.
% ----------------------------------------------------------------------------

% Start the full diagnosis process by asking about symptom categories
start_diagnosis :-
    nl,
    write('═══════════════════════════'), nl,
    write('COMPREHENSIVE CAR DIAGNOSIS'), nl,
    write('═══════════════════════════'), nl,
    write('I will ask you about various symptoms your car may be showing.'), nl,
    write('Please answer yes (y) or no (n) to each question.'), nl,
    write('Type "skip" to skip a category or "done" to finish early.'), nl,
    nl,
    ask_category_symptoms(starting_symptoms, 'ENGINE STARTING ISSUES'),
    ask_category_symptoms(engine_symptoms, 'ENGINE PERFORMANCE'),
    ask_category_symptoms(brake_symptoms, 'BRAKE SYSTEM'),
    ask_category_symptoms(cooling_symptoms, 'COOLING SYSTEM'),
    ask_category_symptoms(electrical_symptoms, 'ELECTRICAL SYSTEM'),
    ask_category_symptoms(transmission_symptoms, 'TRANSMISSION'),
    ask_category_symptoms(warning_light_symptoms, 'WARNING LIGHTS'),
    show_diagnosis_results.

% Quick diagnosis for common problems
quick_diagnosis :-
    nl,
    write('═══════════════'), nl,
    write('QUICK DIAGNOSIS'), nl,
    write('═══════════════'), nl,
    write('Select the main problem you are experiencing:'), nl, nl,
    write('  1. Car won\'t start'), nl,
    write('  2. Engine overheating'), nl,
    write('  3. Brake problems'), nl,
    write('  4. Strange noises'), nl,
    write('  5. Warning lights on dashboard'), nl,
    write('  6. Poor performance/fuel economy'), nl,
    write('  7. Return to main menu'), nl, nl,
    write('Enter your choice (1-7): '),
    read_line_to_string(user_input, Choice),
    process_quick_choice(Choice).

process_quick_choice("1") :- !, ask_starting_symptoms, show_diagnosis_results.
process_quick_choice("2") :- !, ask_overheating_symptoms, show_diagnosis_results.
process_quick_choice("3") :- !, ask_brake_symptoms, show_diagnosis_results.
process_quick_choice("4") :- !, ask_noise_symptoms, show_diagnosis_results.
process_quick_choice("5") :- !, ask_warning_light_symptoms, show_diagnosis_results.
process_quick_choice("6") :- !, ask_performance_symptoms, show_diagnosis_results.
process_quick_choice("7") :- !, main_menu.
process_quick_choice(_) :- 
    write('Invalid choice. Please try again.'), nl, 
    quick_diagnosis.

% Symptom categories for organized questioning
category_symptoms(starting_symptoms, [
    engine_not_starting, no_electrical_power, clicking_sound_when_starting,
    grinding_noise_when_starting, engine_cranks_but_no_start, 
    no_response_when_turning_key, fuel_gauge_low
]).

category_symptoms(engine_symptoms, [
    engine_stalling, engine_misfiring, engine_sputtering, rough_idle,
    poor_acceleration, loss_of_power, engine_sputtering_at_high_speed
]).

category_symptoms(brake_symptoms, [
    squealing_when_braking, grinding_when_braking, longer_stopping_distance,
    soft_brake_pedal, brakes_feel_spongy, vibration_when_braking,
    pulsating_brake_pedal, steering_wheel_shakes_when_braking
]).

category_symptoms(cooling_symptoms, [
    engine_overheating, coolant_puddle_under_car, temperature_fluctuations,
    heater_not_working_properly, visible_coolant_leak, low_coolant_level,
    coolant_leak_front_of_engine, whining_noise_from_engine
]).

category_symptoms(electrical_symptoms, [
    dim_headlights, electrical_flickering, battery_warning_light,
    dead_battery_repeatedly, electrical_accessories_not_working,
    specific_electrical_not_working, no_power_to_accessory
]).

category_symptoms(transmission_symptoms, [
    transmission_slipping, delayed_gear_engagement, grinding_when_shifting,
    burning_smell
]).

category_symptoms(warning_light_symptoms, [
    check_engine_light, temperature_warning_light, brake_warning_light,
    battery_warning_light
]).

% Ask all symptoms in a category
ask_category_symptoms(Category, CategoryName) :-
    nl,
    format('--- ~w ---~n', [CategoryName]),
    category_symptoms(Category, Symptoms),
    ask_symptom_list(Symptoms).

% Ask about a list of symptoms
ask_symptom_list([]).
ask_symptom_list([Symptom|Rest]) :-
    ask_symptom(Symptom, Continue),
    (Continue == done -> true ; ask_symptom_list(Rest)).

% Ask user about a single symptom
ask_symptom(Symptom, Continue) :-
    symptom_description(Symptom, Description),
    format('~w? (y/n/skip/done): ', [Description]),
    read_line_to_string(user_input, Response),
    process_symptom_response(Symptom, Response, Continue).

% Process the user's response to a symptom question
process_symptom_response(Symptom, Response, continue) :-
    string_lower(Response, Lower),
    (Lower = "y" ; Lower = "yes"),
    !,
    assertz(symptom_present(Symptom)),
    format('  ✓ Noted: ~w~n', [Symptom]).

process_symptom_response(Symptom, Response, continue) :-
    string_lower(Response, Lower),
    (Lower = "n" ; Lower = "no"),
    !,
    assertz(symptom_absent(Symptom)).

process_symptom_response(_, Response, skip) :-
    string_lower(Response, Lower),
    Lower = "skip", !,
    write('  → Skipping this category...'), nl.

process_symptom_response(_, Response, done) :-
    string_lower(Response, Lower),
    Lower = "done", !,
    write('  → Finishing questions early...'), nl.

process_symptom_response(Symptom, _, Continue) :-
    write('  Please enter y, n, skip, or done.'), nl,
    ask_symptom(Symptom, Continue).

% Quick diagnosis symptom sets
ask_starting_symptoms :-
    nl, write('--- CAR WON\'T START DIAGNOSIS ---'), nl,
    SymptomList = [engine_not_starting, no_electrical_power, 
                  clicking_sound_when_starting, grinding_noise_when_starting,
                  engine_cranks_but_no_start, no_response_when_turning_key,
                  fuel_gauge_low, dim_headlights, battery_warning_light],
    ask_symptom_list(SymptomList).

ask_overheating_symptoms :-
    nl, write('--- OVERHEATING DIAGNOSIS ---'), nl,
    SymptomList = [engine_overheating, temperature_warning_light,
                  coolant_puddle_under_car, visible_coolant_leak,
                  low_coolant_level, temperature_fluctuations,
                  heater_not_working_properly, whining_noise_from_engine],
    ask_symptom_list(SymptomList).

ask_brake_symptoms :-
    nl, write('--- BRAKE PROBLEM DIAGNOSIS ---'), nl,
    SymptomList = [brake_warning_light, squealing_when_braking,
                  grinding_when_braking, soft_brake_pedal, brakes_feel_spongy,
                  longer_stopping_distance, vibration_when_braking,
                  pulsating_brake_pedal, fluid_puddle_under_car],
    ask_symptom_list(SymptomList).

ask_noise_symptoms :-
    nl, write('--- STRANGE NOISES DIAGNOSIS ---'), nl,
    SymptomList = [clicking_sound_when_starting, grinding_noise_when_starting,
                  squealing_when_braking, grinding_when_braking,
                  grinding_when_shifting, whining_noise_from_engine,
                  whining_from_fuel_tank, ticking_noise_from_engine,
                  loud_exhaust_noise],
    ask_symptom_list(SymptomList).

ask_warning_light_symptoms :-
    nl, write('--- WARNING LIGHT DIAGNOSIS ---'), nl,
    SymptomList = [check_engine_light, temperature_warning_light,
                  brake_warning_light, battery_warning_light,
                  engine_misfiring, rough_idle, poor_acceleration,
                  reduced_fuel_economy],
    ask_symptom_list(SymptomList).

ask_performance_symptoms :-
    nl, write('--- PERFORMANCE ISSUE DIAGNOSIS ---'), nl,
    SymptomList = [poor_acceleration, loss_of_power, engine_sputtering,
                  rough_idle, increased_fuel_consumption, reduced_fuel_economy,
                  engine_misfiring, engine_stalling, black_smoke_from_exhaust],
    ask_symptom_list(SymptomList).

% ----------------------------------------------------------------------------
% SECTION 7: DIAGNOSIS RESULTS DISPLAY
% Shows the diagnosed faults with confidence levels and recommendations.
% ----------------------------------------------------------------------------

show_diagnosis_results :-
    nl,
    write('═════════════════'), nl,
    write('DIAGNOSIS RESULTS'), nl,
    write('═════════════════'), nl,
     nl,
    % Show symptoms that were confirmed
    display_confirmed_symptoms,
    nl,
    % Get and display diagnosed faults
    get_diagnosed_faults(Faults),
    (Faults = [] ->
        display_no_diagnosis
    ;
        display_faults(Faults)
    ),
    nl,
    display_final_disclaimer,
    nl,
    write('Press Enter to return to menu...'),
    read_line_to_string(user_input, _),
    main_menu.

% Display the symptoms user confirmed
display_confirmed_symptoms :-
    write('REPORTED SYMPTOMS:'), nl,
    write('──────────────────────────────────────────────────────────────────────'), nl,
    findall(S, symptom_present(S), Symptoms),
    (Symptoms = [] ->
        write('  No symptoms were reported.'), nl
    ;
        display_symptom_list(Symptoms)
    ).

display_symptom_list([]).
display_symptom_list([Symptom|Rest]) :-
    symptom_description(Symptom, Desc),
    format('  • ~w~n', [Desc]),
    display_symptom_list(Rest).

% Display when no diagnosis could be made
display_no_diagnosis :-
    nl,
    write('DIAGNOSIS: No specific fault could be identified.'), nl,
    nl,
    write('Possible reasons:'), nl,
    write('  • Not enough symptoms were reported'), nl,
    write('  • The problem may not be in our knowledge base'), nl,
    write('  • The symptoms may indicate a rare or complex issue'), nl,
    nl,
    write('RECOMMENDATION:'), nl,
    write('  Please consult a professional mechanic for a thorough'), nl,
    write('  inspection of your vehicle.'), nl.

% Display diagnosed faults with confidence and recommendations
display_faults([]).
display_faults([conf(Confidence, Fault)|Rest]) :-
    fault(Fault, _, Action),
    nl,
    format_fault_name(Fault, FormattedName),
    write('──────────────────────────────────────────────────────────────────────'), nl,
    format('POSSIBLE FAULT: ~w~n', [FormattedName]),
    format('Confidence: ~w%~n', [Confidence]),
    write('──────────────────────────────────────────────────────────────────────'), nl,
    format('Recommended Action:~n', []),
    format('~w~n', [Action]),
    write('──────────────────────────────────────────────────────────────────────'), nl,
    display_faults(Rest).

% Format fault name for display (replace underscores with spaces)
format_fault_name(Fault, Formatted) :-
    atom_string(Fault, FaultStr),
    split_string(FaultStr, "_", "", Words),
    atomics_to_string(Words, " ", Formatted).

% Final disclaimer after results
display_final_disclaimer :-
    nl,
    write('═════════════════════════════════════════'), nl,
    write('REMINDER: This diagnosis is provided for informational purposes'), nl,
    write('only. Always have your vehicle inspected by a qualified mechanic'), nl,
    write('before making repairs, especially for safety-critical systems'), nl,
    write('like brakes and steering.'), nl,
    write('═════════════════════════════════════════'), nl.


% ----------------------------------------------------------------------------
% SECTION 8: UTILITY PREDICATES
% Helper predicates for various operations.
% ----------------------------------------------------------------------------

% Clear all dynamic predicates for a new session
clear_session :-
    retractall(symptom_present(_)),
    retractall(symptom_absent(_)),
    retractall(diagnosed(_)).

% View all faults in the knowledge base
view_all_faults :-
    nl,
    write('══════════════════════════════════'), nl,
    write('KNOWN FAULTS IN THE KNOWLEDGE BASE'), nl,
    write('══════════════════════════════════'), nl,
    nl,
    forall(fault(Fault, Symptoms, Action),
           (format_fault_name(Fault, Name),
            length(Symptoms, NumSymptoms),
            format('• ~w (~w symptoms)~n', [Name, NumSymptoms]),
            write('  Recommendation: '), write(Action), nl,
            nl
           )).

% Display about this system
display_about :-
    nl,
    write('═════════════════'), nl,
    write('ABOUT THIS SYSTEM'), nl,
    write('═════════════════'), nl,
    nl,
    write('This Car Troubleshooting Expert System is developed using Prolog for the course INT430 - Artificial Intelligence.'), nl,
    write('It uses backward chaining to infer possible car faults based on user-reported symptoms.'), nl,
    write('Key Features:'), nl,
    write('- Interactive symptom questioning'), nl,
    write('- Confidence-based diagnosis'), nl,
    write('- Recommended actions for faults'), nl,
    write('- Ethical disclaimers for safe usage'), nl,
    nl,
    write('Team Number 3'), nl,
    write('Members: Moatassim Arbaoui 202210663, Khalid Mohamed 202210406'), nl,
    nl,
    write('Press Enter to return to menu...'), nl,
    read_line_to_string(user_input, _).