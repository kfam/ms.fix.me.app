# encoding: UTF-8
# acts_as_publishable.rb
# Copyright (c) Moneyspyder Ltd
# 
# created: 02-Jan-2008, 17:13:39 

module ActsAsPublishable

  # States, pretty much only progression is DRAFT -> NEW -> PUBLISHED <-> ARCHIVED -> REMOVED
  DRAFT = 1
  SUBMITTED = 2
  PUBLISHED = 3
  ARCHIVED = 4
  REMOVED = 5
  
  STATUS_NAMES = ['', 'Draft'.freeze, 'Submitted'.freeze, 'Published'.freeze, 'Archived'.freeze, 'Deleted'.freeze]
  DROPDOWN_OPTIONS = [
    ['Draft'.freeze, DRAFT],
    ['Submitted'.freeze, SUBMITTED],
    ['Published'.freeze, PUBLISHED],
    ['Archived'.freeze, ARCHIVED],
    ['Deleted'.freeze, REMOVED]
  ]
  
  module ActsAs
    
    def acts_as_publishable(options = {})

      send(:extend, ClassExtensions)
      send(:include, InstanceExtensions)
      
      validates_inclusion_of :published_status, :in => [DRAFT, SUBMITTED, PUBLISHED, ARCHIVED, REMOVED]
      
      before_validation( :on => :create) do |r|
        self.published_status ||= SUBMITTED
        self.published_status = SUBMITTED unless [DRAFT, SUBMITTED, PUBLISHED, ARCHIVED, REMOVED].include?(self.published_status)
        true
      end
      
      scope :drafts, :conditions => { :published_status => DRAFT }
      scope :submitted, :conditions => { :published_status => SUBMITTED }
      scope :published, :conditions => { :published_status => PUBLISHED }
      scope :archived, :conditions => { :published_status => ARCHIVED }
      scope :removed, :conditions => { :published_status => REMOVED }
      
      scope :public_viewable, :conditions => { :published_status => [PUBLISHED, ARCHIVED] }
      scope :alive, :conditions => { :published_status => [SUBMITTED, PUBLISHED, ARCHIVED] }
      
      scope :draft_or_alive, :conditions => { :published_status => [DRAFT, SUBMITTED, PUBLISHED, ARCHIVED] }
    end    
    
  end
  
  module ClassExtensions
    
    def archive_published(conditions = nil)
      published.update_all ['published_status = ?', ARCHIVED], conditions
    end
    
    def new_draft(spec = {})
      new(spec.merge(:published_status => DRAFT))
    end
    
    def create_draft!(spec = {})
      model = create(spec)
      model.published_status = DRAFT
      model.save!
      model
    end

    def published_status_counts(allproducts=true,superproducts=false)
      if allproducts
        return {
        DRAFT => self.drafts.size,
        SUBMITTED => self.submitted.size,
        PUBLISHED => self.published.size,
        ARCHIVED => self.archived.size,
        REMOVED => self.removed.size
        }
      elsif superproducts
        return {
        DRAFT => self.superproducts.drafts.size,
        SUBMITTED => self.superproducts.submitted.size,
        PUBLISHED => self.superproducts.published.size,
        ARCHIVED => self.superproducts.archived.size,
        REMOVED => self.superproducts.removed.size
        }
      else
        return {
        DRAFT => self.notsuperproducts.drafts.size,
        SUBMITTED => self.notsuperproducts.submitted.size,
        PUBLISHED => self.notsuperproducts.published.size,
        ARCHIVED => self.notsuperproducts.archived.size,
        REMOVED => self.notsuperproducts.removed.size
        }
      end
    end
    
  end

  module InstanceExtensions
  
    def destroyable?
      draft?
    end
    
    # draft 
    def draft?
      published_status == DRAFT
    end
    
    def not_draft?
      !draft?
    end
    
    # submitted
    def submittable?
      draft?
    end

    def submit(new_attributes = {})
      return false unless submittable?
      self.published_status = SUBMITTED
      update_attributes(new_attributes)
      save
    end
    
    def submit!(new_attributes = {})
      raise "invalid state" unless submittable?
      
      self.published_status = SUBMITTED
      update_attributes(new_attributes)
      save!
    end
    
    def submitted?
      published_status == SUBMITTED
    end
    
    # published
    def publishable?
      submitted?
    end
    
    def publish!
      raise "invalid state" unless publishable?
      
      transaction do
        # a bit of a hack, but if there are any published things with our slug, archive them first
        self.class.archive_published :slug => slug if respond_to?(:slug)

        self.published_status = PUBLISHED
        save!
      end
    end
    
    def published?
      published_status == PUBLISHED
    end
    
    def published_status_name
      STATUS_NAMES[published_status]
    end
    
    # archived
    def archivable?
      published?
    end
    
    def archive!
      raise "invalid state" unless archivable?
      self.published_status = ARCHIVED
      save!
    end
    
    def archived?
      published_status == ARCHIVED
    end
    
    # removed
    def unarchiveable?
      archived?
    end
    
    def unarchive!
      raise "invalid state" unless removable?
      self.published_status = PUBLISHED
      save!
    end
    
    # removed
    def removable?
      draft? || submitted? || archived?
    end
    
    def remove!
      raise "invalid state" unless removable?
      
      # we're going to force this update through, I don't care if it's invalid if it's getting deleted...
      self.published_status = REMOVED
      self.save(:validate => false) || raise(ActiveRecord::RecordNotSaved)
    end
        
    def removed?
      published_status == REMOVED
    end
    
    def undeleteable?
      removed?
    end
    
    def undelete!
      raise "invalid state" unless undeleteable?
      self.published_status = ARCHIVED
      save!
    end
    alias_method :unremove!, :undelete!
    
    # public
    def public?
      published? || archived?
    end
    
    def published_version
      @published_version ||= published? ? self : self.class.published.find_by_slug(slug)
    end
    
    def previous_versions
      @archived_versions ||= published? ? self.class.archived.find_all_by_slug(slug) : []
    end
    
    def future_versions
      @future_versions ||= published? ? self.class.submitted.find_all_by_slug(slug) : []
    end
    
    def draft_versions
      @draft_versions ||= published? ? self.class.drafts.find_all_by_slug(slug) : []
    end

    # used when cloning an item, shouldn't be used anywhere else
    def make_draft!
      self.published_status = DRAFT
      save!
    end
  end
  
end


ActiveRecord::Base.send(:extend, ActsAsPublishable::ActsAs)