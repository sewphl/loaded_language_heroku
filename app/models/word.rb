require 'pry'
class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates :entry, presence: true, format: { with: /(^[-a-zA-Z]+(\s+[-a-zA-Z]+)*$)/i, message: "cannot begin or end with spaces, and cannot contain numbers or special characters."}
  validates_uniqueness_of :entry, :case_sensitive => false, :message=>"is already in the database."
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }

  ##return word IDs (not indices) of array of words
  ##after sorting alphabetically.
  def self.alphabetize_words_ids(words)
    @word_ids_abc = []
    ##indices of words array after sorting alphabetically:
    @indices = words.pluck(:entry).map.with_index.sort_by{|x| x.first.downcase}.map(&:last)
    ##words array, sorted alphabetically:
    @words_abc = @indices.map { |index| words[index] }
    ##return just the word IDs of abc-sorted words array:
    @words_abc.each do |w|
      @word_ids_abc << w.id
    end
    @word_ids_abc
  end

end
