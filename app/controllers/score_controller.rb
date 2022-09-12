class ScoreController < ApplicationController
  def list
    # List Page
    @maxScore = Subject.maximum("score")
    @maxSubject = Subject.where(score: @maxScore).pluck(:name)[0]
    @totalScore = Subject.sum("score")
  end

  def edit
    # Edit Page
    @sname = params[:sname]
    @sid = params[:sid]
    @sscore = params[:sscore]
    puts 'Starting edit function'
    puts @sname
    puts @sid
  end

  def editHandler
    @sid = params[:sid].to_i
    @editName = params[:editName]
    @editScore = params[:editScore]
    
    editSubject = Subject.find(@sid)
    editSubject.update(name: @editName, score: @editScore)
    puts "Edited subject with id: #{@sid}"
    redirect_to '/score/list' # refresh the page
  end

  def delete
    # Delete Function
    @sid = params[:sid]
    Subject.delete(@sid)
    puts "Deleted subject with sid: #{@sid}"
    redirect_to '/score/list' # refresh the page
  end
end
