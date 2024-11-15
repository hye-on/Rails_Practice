class BannedWordsController < ApplicationController
  before_action :set_banned_word, only: %i[show edit update destroy]
  skip_before_action :set_banned_word, only: :ui_schema

  def ui_schema
    render json: {
      fields: [
        { label: '금지 단어', type: 'text', name: 'word', required: true },
        { label: '정책', type: 'select', name: 'policy', options: %w[ban warn], required: true },
        { label: '매칭 대상', type: 'select', name: 'match_target', options: %w[title_only content_only both],
          required: true }
      ]
    }
  end

  def list_ui_schema
    render json: {
      fields: [
        {
          name: 'word',
          label: '금지 단어',
          type: 'text',
          required: true,
          sortable: true
        },
        {
          name: 'policy',
          label: '정책',
          type: 'select',
          required: true,
          options: %w[ban warn]
        },
        {
          name: 'match_target',
          label: '매칭 대상',
          type: 'select',
          required: true,
          options: %w[title_only content_only both]
        }
      ],
      actions: [
        {
          type: 'delete',
          label: '삭제',
          confirmMessage: '정말 삭제하시겠습니까?',
          style: {
            color: 'danger'
          }
        },
        {
          type: 'edit',
          label: '수정',
          confirmMessage: '정말 수정하시겠습니까?',
          style: {
            color: 'primary'
          },
          path: '/banned-words/:id/edit' 
        }
      ],
      layout: {
        type: 'table',
        pagination: {
          itemsPerPage: 10
        }
      }
    }
  end

  # HTML 요청을 위한 index 액션
  def index
    # HTML 뷰 렌더링을 위해 모든 금지 단어 로드
    @banned_words = BannedWord.all
  end

  # JSON 응답을 위한 index_json 액션
  def index_json
    banned_words = BannedWord.all
    render json: banned_words
  end

  # GET /banned-words/1 or /banned_words/1.json
  def show; end

  # GET /banned-words/new
  def new
    @banned_word = BannedWord.new
  end

  # GET /banned-words/1/edit
  def edit; end

  # POST /banned-words or /banned_words.json
  def create
    @banned_word = BannedWord.new(banned_word_params)

    respond_to do |format|
      if @banned_word.save
        format.html { redirect_to banned_word_url(@banned_word), notice: 'Banned word was successfully created.' }
        format.json { render json: { message: 'Banned word created successfully' }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @banned_word.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banned-words/1 or /banned_words/1.json
  def update
    respond_to do |format|
      if @banned_word.update(banned_word_params)
        format.html { redirect_to banned_word_url(@banned_word), notice: 'Banned word was successfully updated.' }
        format.json { render :show, status: :ok, location: @banned_word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @banned_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banned-words/1 or /banned_words/1.json
  def destroy
    banned_word = BannedWord.find(params[:id])
    banned_word.destroy
    respond_to do |format|
      format.json { head :no_content } # JSON 응답으로 처리
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_banned_word
    @banned_word = BannedWord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def banned_word_params
    params.require(:banned_word).permit(:word, :policy, :match_target, exceptions: [])
  end
end
