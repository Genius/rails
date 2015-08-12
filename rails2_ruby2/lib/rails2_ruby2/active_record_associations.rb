module ActiveRecord
  module Associations
    class AssociationProxy
      def send(method, *args)
        if proxy_respond_to?(method, true)
          super
        else
          load_target
          @target.send(method, *args)
        end
      end
    end
  end
end


module ActiveRecord::AutosaveAssociation
  private

  def save_collection_association(reflection)
    if association = association_instance_get(reflection.name)
      autosave = reflection.options[:autosave]

      if records = associated_records_to_validate_or_save(association, @new_record_before_save, autosave)
        records.each do |record|
          next if record.destroyed?

          if autosave && record.marked_for_destruction?
            association.destroy(record)
          elsif autosave != false && (@new_record_before_save || record.new_record?)
            if autosave
              saved = association.send(:insert_record, record, false, false)
            else
              association.send(:insert_record, record)
            end
          elsif autosave
            saved = record.save(false)
          end

          raise ActiveRecord::Rollback if saved == false
        end
      end

      # reconstruct the SQL queries now that we know the owner's id
      association.send(:construct_sql) if association.respond_to?(:construct_sql, true)
    end
  end
end
