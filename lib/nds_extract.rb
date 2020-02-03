require 'directors_database'
pp directors_database

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end

def movies_with_director_key(name, movies_collection)
  result = []
  index = 0
  while index < movies_collection.length do
    movie_data = movies_collection[index]
    result << movie_with_director_name(name, movie_data)
    index += 1
  end
  result
end


def gross_per_studio(collection)
  result = {}
  index = 0
  while index < collection.length do
    movie = collection[index]
    if !result[movie[:studio]]
      result[movie[:studio]] = movie[:worldwide_gross]
    else
      result[movie[:studio]] += movie[:worldwide_gross]
    end
    index += 1
  end
  result
end

def movies_with_directors_set(source)
  index = 0
  a_o_a_movies_by_dir = []
  while index < source.length do
    dir_info_hash = source[index]
    director_name = dir_info_hash[:name]
    directors_movies = dir_info_hash[:movies]
    a_o_a_movies_by_dir << movies_with_director_key(director_name, directors_movies)
    index += 1
  end
  a_o_a_movies_by_dir
end

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
