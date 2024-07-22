# frozen_string_literal: true

Rails.logger.debug 'Started seeding'

Difficulty.names.each_key do |name|
  Difficulty.find_or_create_by!(name:)
end
Rails.logger.debug { "Seeded #{Difficulty.count} difficulties" }

organizations = ['Study Seed Demo']

organizations.each do |name|
  Organization.find_or_create_by!(name:)
end
Rails.logger.debug { "Seeded #{Organization.count} organizations" }

course_groups = ['1st Form Courses']

course_groups.each do |course_group_name|
  CourseGroup.find_or_create_by!(name: course_group_name) do |cg|
    cg.organization = Organization.all.sample(1).first
  end
end
Rails.logger.debug { "Seeded #{CourseGroup.count} course groups" }

courses_data = {
  'Maths' => {
    description: 'The study of numbers, quantities, shapes, and patterns, exploring concepts such as algebra, geometry, calculus, and statistics.',
    topics: [
      'Fractions and Decimals: Understanding and converting between fractions, decimals, and percentages.',
      'Basic Algebra: Introduction to variables, simple equations, and solving for unknowns.',
      'Geometry: Basic shapes, angles, area, and perimeter.',
      'Integers and Rational Numbers: Adding, subtracting, multiplying, and dividing positive and negative numbers.',
      'Probability and Statistics: Simple probability, mean, median, mode, and interpreting data.'
    ]
  },
  'Physics' => {
    description: 'The science of matter, energy, and the interactions between them, covering topics like mechanics, thermodynamics, electromagnetism, and quantum physics.',
    topics: [
      'Forces and Motion: Basic principles of motion, speed, velocity, and Newton’s laws of motion.',
      'Energy: Different forms of energy, energy transfer, and conservation of energy.',
      'Waves: Introduction to sound and light waves, their properties, and behavior.',
      'Electricity and Magnetism: Basic electrical circuits, conductors, insulators, and the relationship between electricity and magnetism.',
      'Matter and Its Properties: States of matter (solid, liquid, gas), and properties like density and buoyancy.'
    ]
  },
  'Chemistry' => {
    description: 'The study of substances, their properties, compositions, and reactions, focusing on elements, compounds, and chemical processes.',
    topics: [
      'Atoms and Molecules: Basic structure of atoms, elements, and the periodic table.',
      'Chemical Reactions: Simple chemical reactions, reactants, products, and conservation of mass.',
      'Acids and Bases: Understanding pH, properties of acids and bases, and simple neutralization reactions.',
      'Elements and Compounds: Differences between elements, compounds, and mixtures.',
      'States of Matter: Solid, liquid, gas, and changes of state like melting, freezing, and boiling.'
    ]
  },
  'Biology' => {
    description: 'The science of life and living organisms, examining their structure, function, growth, evolution, and interactions with the environment.',
    topics: [
      'Cell Structure and Function: Basic cell parts (nucleus, cytoplasm, cell membrane) and their functions.',
      'Human Body Systems: Overview of major systems (digestive, respiratory, circulatory, nervous) and their functions.',
      'Plants: Photosynthesis, parts of a plant, and their functions.',
      'Ecosystems and Habitats: Different types of ecosystems, food chains, and the importance of biodiversity.',
      'Genetics: Basic principles of heredity, genes, and DNA.'
    ]
  },
  'History' => {
    description: 'The study of past events, societies, and civilizations, analyzing historical documents, artifacts, and other sources to understand human development over time.',
    topics: [
      'Ancient Civilizations: Overview of ancient Egypt, Greece, and Rome.',
      'Middle Ages: Life in medieval times, feudalism, and significant events like the Black Plague.',
      'Exploration and Discovery: Age of Exploration, key explorers, and their impact on the world.',
      'American Revolution: Causes, key events, and important figures of the American Revolution.',
      'World Wars: Basic introduction to World War I and World War II, their causes, and major events.'
    ]
  }
}

courses_data.each do |course_name, course_info|
  # Find or create the course
  course = Course.find_or_create_by!(name: course_name) do |c|
    c.description = course_info[:description]
    c.is_private = false
    c.course_group = CourseGroup.all.sample(1).first
  end

  course_info[:topics].each_with_index do |description, index|
    # Extract the topic name and description
    topic_name, topic_description = description.split(': ', 2)

    Topic.find_or_create_by!(name: topic_name) do |t|
      t.description = topic_description
      t.course = course
      t.order = index + 1
    end
  end
end
Rails.logger.debug { "Seeded #{Course.count} courses and #{Topic.count} topics." }
